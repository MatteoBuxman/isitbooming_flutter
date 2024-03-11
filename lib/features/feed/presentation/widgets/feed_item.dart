import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sandbox/features/feed/data/models/boom.dart';
import 'package:sandbox/features/feed/presentation/widgets/boom_interactions.dart';
import 'package:sandbox/features/feed/presentation/widgets/video_unit.dart';

class FeedItem extends StatefulWidget {
  
  final Boom boomModel;

  const FeedItem(this.boomModel, {super.key});

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Stack(
        children: [
          SafeArea(
            child: Center(
              child: VideoUnit(
                widget.boomModel.controller,
              ),
            ),
          ),
          BoomInteractions(boomModel: widget.boomModel,),
        ],
      ),
    );
  }
}
