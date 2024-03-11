import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoUnit extends StatefulWidget {
  final VideoPlayerController _controller;
  const VideoUnit(VideoPlayerController controller, {super.key})
      : _controller = controller;

  @override
  State<VideoUnit> createState() => _VideoUnitState();
}

class _VideoUnitState extends State<VideoUnit> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void stopStartBoom() {
    if (widget._controller.value.isPlaying) {
      widget._controller.pause();
    } else {
      widget._controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => stopStartBoom(),
      child: widget._controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: widget._controller.value.aspectRatio,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: VideoPlayer(widget._controller)),
            )
          : Container(),
    );
  }
}
