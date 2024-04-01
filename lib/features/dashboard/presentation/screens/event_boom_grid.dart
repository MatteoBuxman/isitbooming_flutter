import 'package:flutter/material.dart';
import 'package:sandbox/features/dashboard/data/models/event_boom_grid.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/booms/widgets/boom_thumbnail.dart';

class EventBoomGridScreen extends StatefulWidget {
  final EventBoomGrid boomGrid;

  const EventBoomGridScreen(this.boomGrid, {super.key});

  @override
  State<EventBoomGridScreen> createState() => _EventBoomGridScreenState();
}

class _EventBoomGridScreenState extends State<EventBoomGridScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boomGrid.eventName),
      ),
      body: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 9 / 16,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: widget.boomGrid.booms.length,
      itemBuilder: (context, index) {
        return BoomThumbnailWidget(widget.boomGrid.booms[index]);
      },
    ),
    );
  }
}