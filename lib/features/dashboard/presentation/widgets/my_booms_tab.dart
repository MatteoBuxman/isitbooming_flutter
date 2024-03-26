import 'package:flutter/material.dart';
import 'package:sandbox/features/dashboard/data/models/boom_thumbnail.dart';
import 'package:sandbox/features/dashboard/data/repositories/my_booms_repository.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/boom_thumbnail.dart';

class MyBoomsTab extends StatefulWidget {
  const MyBoomsTab({super.key});

  @override
  State<MyBoomsTab> createState() => _MyBoomsTabState();
}

class _MyBoomsTabState extends State<MyBoomsTab> {

  final dashboardRepository = MyBoomsRepository();
  final List<BoomThumbnail> gridContents = [];

  @override
  void initState() {
    //Fetch and assign grid contents
    dashboardRepository.getBoomThumbnails().then((value) {
      setState(() {
        gridContents.addAll(value);
      });
    });

    super.initState();
  }

  @override
    @override
  Widget build(BuildContext context) {
    return gridContents.isNotEmpty ? GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 9 / 16,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: gridContents.length,
      itemBuilder: (context, index) {
        BoomThumbnail boomThumbnail = gridContents[index];
        return BoomThumbnailWidget(boomThumbnail);
      },
    ) : const Text("Your posted booms will appear here");
  }
}

 