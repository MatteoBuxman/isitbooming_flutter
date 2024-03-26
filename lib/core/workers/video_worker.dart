// Copyright 2022 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

///////////////////////////////////////////////////////////////////////////////
// **WARNING:** This is not production code and is only intended to be used for
// demonstration purposes.
//
// The following database works by spawning a background isolate and
// communicating with it over Dart's SendPort API. It is presented below as a
// demonstration of the feature "Background Isolate Channels" and shows using
// plugins from a background isolate. The [VideoWorker] operates on the root
// isolate and the [_VideoWorkerServer] operates on a background isolate.
//
// Here is an example of the protocol they use to communicate:
//
//  _________________                         ________________________
//  [:VideoWorker]                         [:_VideoWorkerServer]
//  -----------------                         ------------------------
//         |                                              |
//         |<---------------(init)------------------------|
//         |----------------(init)----------------------->|
//         |<---------------(ack)------------------------>|
//         |                                              |
//         |----------------(add)------------------------>|
//         |<---------------(ack)-------------------------|
//         |                                              |
//         |----------------(query)---------------------->|
//         |<---------------(result)----------------------|
//         |<---------------(result)----------------------|
//         |<---------------(done)------------------------|
//
///////////////////////////////////////////////////////////////////////////////

/// The size of the database entries in bytes.
const int _entrySize = 256;

/// All the command codes that can be sent and received between [VideoWorker] and
/// [_VideoWorkerServer].
enum _Codes {
  init,
  createControllers,
  ack,
  result,
  done,
}

/// A command sent between [VideoWorker] and [_VideoWorkerServer].
class _Command {
  const _Command(this.code, {this.arg0, this.arg1});

  final _Codes code;
  final Object? arg0;
  final Object? arg1;
}

/// A VideoWorker that stores entries of strings to disk where they can be
/// queried.
///
/// All the disk operations and queries are executed in a background isolate
/// operating. This class just sends and receives messages to the isolate.
class VideoWorker {
  VideoWorker._(this._isolate);

  final Isolate _isolate;
  late final SendPort _sendPort;
  // Completers are stored in a queue so multiple commands can be queued up and
  // handled serially.
  final Queue<Completer<void>> _completers = Queue<Completer<void>>();
  // Similarly, StreamControllers are stored in a queue so they can be handled
  // asynchronously and serially.
  final Queue<StreamController<VideoPlayerController>> _resultsStream =
      Queue<StreamController<VideoPlayerController>>();

  /// Open the database at [path] and launch the server on a background isolate..
  static Future<VideoWorker> start() async {
    final ReceivePort receivePort = ReceivePort();
    final Isolate isolate =
        await Isolate.spawn(_VideoWorkerServer._run, receivePort.sendPort);
    final VideoWorker result = VideoWorker._(isolate);
    Completer<void> completer = Completer<void>();
    result._completers.addFirst(completer);
    receivePort.listen((Object? message) {
      result._handleCommand(message as _Command);
    });
    await completer.future;
    return result;
  }

  /// Returns all the strings in the database that contain [query].
  Stream<VideoPlayerController> createInitializedControllers(
      List<String> videoURLs) {
    // No processing happens on the calling isolate, it gets delegated to the
    // background isolate, see [__VideoWorkerServer._doFind].
    StreamController<VideoPlayerController> resultsStream =
        StreamController<VideoPlayerController>();
    _resultsStream.addFirst(resultsStream);
    _sendPort.send(_Command(_Codes.createControllers, arg0: videoURLs));
    return resultsStream.stream;
  }

  /// Handler invoked when a message is received from the port communicating
  /// with the database server.
  void _handleCommand(_Command command) {
    switch (command.code) {
      case _Codes.init:
        _sendPort = command.arg0 as SendPort;
        // ----------------------------------------------------------------------
        // Before using platform channels and plugins from background isolates we
        // need to register it with its root isolate. This is achieved by
        // acquiring a [RootIsolateToken] which the background isolate uses to
        // invoke [BackgroundIsolateBinaryMessenger.ensureInitialized].
        // ----------------------------------------------------------------------
        RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
        _sendPort.send(_Command(
          _Codes.init,
          arg0: rootIsolateToken,
        ));
        break;
      case _Codes.ack:
        _completers.removeLast().complete();
        break;
      case _Codes.result:
        _resultsStream.last.add(command.arg0 as VideoPlayerController);
        break;
      case _Codes.done:
        
        _resultsStream.removeLast().close();
        
        break;
      default:
        print('VideoWorker unrecognized command: ${command.code}');
    }
  }

  /// Kills the background isolate and its database server.
  void stop() {
    _isolate.kill();
  }
}

/// The portion of the [VideoWorker] that runs on the background isolate.
///
/// This is where we use the new feature Background Isolate Channels, which
/// allows us to use plugins from background isolates.
class _VideoWorkerServer {
  _VideoWorkerServer(this._sendPort);

  final SendPort _sendPort;

  /// The main entrypoint for the background isolate sent to [Isolate.spawn].
  static void _run(SendPort sendPort) {
    ReceivePort receivePort = ReceivePort();
    sendPort.send(_Command(_Codes.init, arg0: receivePort.sendPort));
    final _VideoWorkerServer server = _VideoWorkerServer(sendPort);
    receivePort.listen((Object? message) async {
      final _Command command = message as _Command;
      server._handleCommand(command);
    });
  }

  /// Handle the [command] received from the [ReceivePort].
  Future<void> _handleCommand(_Command command) async {
    switch (command.code) {
      case _Codes.init:

        // ----------------------------------------------------------------------
        // The [RootIsolateToken] is required for
        // [BackgroundIsolateBinaryMessenger.ensureInitialized] and must be
        // obtained on the root isolate and passed into the background isolate via
        // a [SendPort].
        // ----------------------------------------------------------------------
        RootIsolateToken rootIsolateToken = command.arg0 as RootIsolateToken;
        // ----------------------------------------------------------------------
        // [BackgroundIsolateBinaryMessenger.ensureInitialized] for each
        // background isolate that will use plugins. This sets up the
        // [BinaryMessenger] that the Platform Channels will communicate with on
        // the background isolate.
        // ----------------------------------------------------------------------
        BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

        //Acknowledge init
        _sendPort.send(const _Command(_Codes.ack, arg0: null));
        break;
      case _Codes.createControllers:
        _createControllers(command.arg0 as List<String>);
        break;
      default:
        print('_VideoWorkerServer unrecognized command ${command.code}');
    }
  }

  /// Perform the add entry operation.
  void _createControllers(List<String> videoURLs) async {
    for (var url in videoURLs) {
      final uriObject = Uri.parse(url);
      final controller = VideoPlayerController.networkUrl(uriObject);
      //TODO: I can't for the love of god get the initialization of the video controllers to work on the spawned isolate.
      //TODO: This was the whole point of this class

      //await controller.initialize();

      _sendPort.send(_Command(_Codes.result, arg0: controller));
    }
    _sendPort.send(const _Command(
      _Codes.done,
    ));
  }
}
