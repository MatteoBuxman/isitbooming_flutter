import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/core/feed/feed_controller.dart';

import 'package:sandbox/features/dashboard/business_logic/dashboard_feed_cubit.dart';
import 'package:sandbox/features/dashboard/data/models/boom_thumbnail.dart';
import 'package:sandbox/features/feed/presentation/widgets/feed_scroll.dart';

class BoomThumbnailWidget extends StatefulWidget {
  final BoomThumbnail thumbnail;

  const BoomThumbnailWidget(this.thumbnail, {super.key});

  @override
  State<BoomThumbnailWidget> createState() => _BoomThumbnailWidgetState();
}

class _BoomThumbnailWidgetState extends State<BoomThumbnailWidget> {
  void _showFullscreenVideoBottomSheet(BuildContext context) {
    DashboardFeedCubit feedController = DashboardFeedCubit();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            // Close the full-screen video player when the back button is pressed
            Navigator.pop(context);
            feedController.reportUserClickAway();
            return false;
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      // Close the full-screen video player when the close icon is pressed
                      Navigator.pop(context);
                      
                    },
                  ),
                ),
                BlocProvider<FeedController>(
                    create: (context) => feedController,
                    child: Expanded(
                        child: FeedScroll(controllingCubit: feedController))),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showFullscreenVideoBottomSheet(context);
        print('Clicked on ${widget.thumbnail.furtherInformation}');
      },
      child: Image.network(
        widget.thumbnail.thumbnailLink.toString(),
        fit: BoxFit.cover,
      ),
    );
  }
}
