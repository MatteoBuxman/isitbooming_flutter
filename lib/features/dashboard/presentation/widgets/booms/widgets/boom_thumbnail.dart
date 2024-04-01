import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/core/feed/feed_controller.dart';
import 'package:sandbox/features/dashboard/business_logic/dashboard_feed_cubit.dart';
import 'package:sandbox/features/feed/data/models/boom.dart';
import 'package:sandbox/features/feed/presentation/widgets/feed_scroll.dart';

class BoomThumbnailWidget extends StatefulWidget {
  final Boom boom;

  const BoomThumbnailWidget(this.boom, {super.key});

  @override
  State<BoomThumbnailWidget> createState() => _BoomThumbnailWidgetState();
}

class _BoomThumbnailWidgetState extends State<BoomThumbnailWidget> {
  void _showFullscreenVideoBottomSheet(BuildContext context) {
    DashboardFeedCubit controllingCubit = DashboardFeedCubit();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.black,
          body: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: SafeArea(
                child: Stack(
                  children: [
                    BlocProvider<FeedController>.value(
                      value: controllingCubit,
                      child: FeedScroll(controllingCubit: controllingCubit),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          controllingCubit.close();
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          weight: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showFullscreenVideoBottomSheet(context);
      },
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: widget.boom.thumbnailURL,
        errorWidget: (context, url, error) => const Icon(Icons.error),
     ),
    );
  }
}
