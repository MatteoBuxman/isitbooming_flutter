import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:sandbox/features/feed/business_logic/states/feed_state.dart';
import 'package:sandbox/features/feed/data/models/boom.dart';
import 'package:sandbox/features/feed/data/models/boom_feed_unit.dart';
import 'package:sandbox/features/feed/data/repository/get_feed_booms_repository.dart';

//The controller which plays, pauses, and disposes of video controllers on a user swipe.
class BoomFeedCubit extends Cubit<FeedState> {
  final feedBoomRepository = GetFeedBoomsRepository();

  //The working list of all BoomFeedUnits
  final feedUnitList = <BoomFeedUnit>[];

  //List of the booms in the feed, this is the sum of all the booms in all the Feed Units in the feedUnitList
  final feedList = <Boom>[];

  //If currentPlayingBoomIndex is before this variable, _nextUnitExists = true
  //If currentPlayingBoomIndex is after this variable, _nextUnitExists = false
  //This is set to the index of the first boom in the final block within the feedList
  int indexOfEdgeBetweenFinalAndPenultimateBlocksOfVideos = 0;

  //Index of the current playing boom in the feed
  int currentPlayingBoomIndex = 0;

  //The index of the current in focus BoomFeedUnit
  int currentFocused = 0;

  //Variable to track whether this Cubit has been initialized.
  bool isInitialized = false;

  BoomFeedCubit() : super(LoadingFeedState()) {
    feedBoomRepository.requestFeedUnit().then(((value) {
      //Check if the request was successful
      if (value.fetchStatus == FetchStatus.error) {
        throw Exception('The initial BoomFeedUnit could not be fetched.');
      }

      //Add the first unit to the list of units
      feedUnitList.add(value);

      //Merge booms with the feedList
      feedList.addAll(value.booms);

      //Initialize the first couple of videos min(initialUnit.size, 3), and pass in the function to call once these initial booms have been initialized.
      return initializeInitialBoomsInFeed(value,
          () => emit(LoadedFeedState(feedList, currentPlayingBoomIndex)));
    })).then((_) {
      isInitialized = true;

      //Emit loaded state to the presentation layer
      emit(LoadedFeedState(feedList, 0));
    }).catchError((error) {
      print(error);
    });
  }

  //Boolean to track whether a subsequent unit exists in the feedUnitList
  //In order to determine whether a new unit should be requested or if a user has just
  //scrolled really far back in the feed.
  bool get _nextUnitExists =>
      currentPlayingBoomIndex <
      indexOfEdgeBetweenFinalAndPenultimateBlocksOfVideos;

  // //Returns the currently focused Boom Feed Unit (Mostly used for internal class operations)
  // BoomFeedUnit get currentUnit => feedUnitList[currentFocused];

  // //Returns the index in the Boom Feed Unit of the currently playing boom (ranges between 0 - 9 since boom feed units hold a maximum of 10 booms )
  // int get currentPlayingIndex => currentUnit.currentIndex;

  //Return the current playing boom
  Boom get currentPlayingBoom => feedList[currentPlayingBoomIndex];

  void pauseCurrentPlayer() {
    currentPlayingBoom.controller.pause();
    print(currentPlayingBoomIndex);
  }

  void playCurrentPlayer() {
    currentPlayingBoom.controller.play();
  }

  void reportScroll(int newIndex) {
    //Forward scroll
    if (newIndex > currentPlayingBoomIndex) {
      //Request the next Feed Unit if the current index = current_unit_size - 4 and there is no subsequent unit
      //4 is a constant that can be changed accordingly, this will change the point in the feed when the next feed block is fetched.
      if (currentPlayingBoomIndex == feedList.length - 4 && !_nextUnitExists) {
        //This will run before the _requestNextFeedUnit has completed
        forwardScroll(newIndex);
        currentPlayingBoomIndex++;

        //Request the new feed unit and emit the updated feed when the fetch is complete
        _requestNextFeedUnit(newIndex).then((_) {
          emit(LoadedFeedState(feedList, currentPlayingBoomIndex));
        });

        return;
      }

      forwardScroll(newIndex);
      currentPlayingBoomIndex++;
    }
    //Backward Scroll
    else {
      backwardScroll(newIndex);
      currentPlayingBoomIndex--;
    }
  }

  //Handle a forward scroll
  void forwardScroll(int newIndex) {
    /// Stop [index - 1] controller
    _stopControllerAtIndex(newIndex - 1);

    /// Dispose [index - 2,3] controller
    _disposeControllerAtIndex(newIndex - 3);

    /// Play current video (already initialized)
    _playControllerAtIndex(newIndex);

    /// Initialize [index + 1] controller
    _initializeControllerAtIndex(newIndex + 2);
  }

  //Handle a backward scroll
  void backwardScroll(int newIndex) {
    _stopControllerAtIndex(newIndex + 1);

    /// Dispose [index + 2] controller
    _disposeControllerAtIndex(newIndex + 3);

    /// Play current video (already initialized)
    _playControllerAtIndex(newIndex);

    /// Initialize [index - 1] controller
    _initializeControllerAtIndex(newIndex - 2);
  }

  //Request the next feed unit
  Future<void> _requestNextFeedUnit(int newIndex) async {
    final nextUnit = await feedBoomRepository.requestFeedUnit();

    //Add the Boom feed unit to the list of Boom Feed Units
    feedUnitList.add(nextUnit);

    //Update edge index
    indexOfEdgeBetweenFinalAndPenultimateBlocksOfVideos = feedList.length;

    //Add the booms to the feed
    feedList.addAll(nextUnit.booms);

    print("Next unit added");
  }

  //Called by the constructor to inititialize the first couple of booms and play the first one
  Future<void> initializeInitialBoomsInFeed(
      BoomFeedUnit initialUnit, void Function() callback) async {
    int amountOfBoomsToInitialize = min(initialUnit.booms.length, 3);

    for (var i = 0; i < amountOfBoomsToInitialize; i++) {
      switch (i) {
        case 0:
          final controller = feedList[i].controller;
          controller.setLooping(true);
          controller.initialize().then((value) {
            controller.play().then((value) => callback());
          });
        default:
          final controller = feedList[i].controller;
          controller.setLooping(true);
          controller.initialize();
      }
    }
  }

  void _stopControllerAtIndex(int index) {
    if (feedList.length > index && index >= 0) {
      /// Get controller at [index]
      final controller = feedList[index].controller;

      /// Pause
      controller.pause();

      /// Reset postiton to beginning
      controller.seekTo(const Duration());
      print('stopped $index');
    }
  }

  void _disposeControllerAtIndex(int index) {
    if (feedList.length > index && index >= 0) {
      /// Get controller at [index]
      final controller = feedList[index].controller;

      /// Dispose controller
      controller.dispose();
      print('Disposed $index');
    }
  }

  void _playControllerAtIndex(int index) {
    if (feedList.length > index && index >= 0) {
      /// Get controller at [index]
      final controller = feedList[index].controller;

      if (controller.value.isInitialized) {
        /// Play controller
        controller.play();

        controller.setLooping(true);
      } else {
        _initializeControllerAtIndex(index).then((value) {
          feedList[index].controller.play();
          feedList[index].controller.setLooping(true);
        });
      }
      print('playing $index');
    }
  }

  Future _initializeControllerAtIndex(int index) async {
    if (feedList.length > index && index >= 0) {
      /// Initialize controller at the correct index
      feedList[index].initialize();

      print('initialized $index');
    }
  }
}
