import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/features/feed/business_logic/boom_feed_cubit.dart';
import 'package:sandbox/features/feed/business_logic/states/feed_state.dart';
import 'package:sandbox/features/feed/presentation/widgets/feed_item.dart';
import 'package:sandbox/features/feed/presentation/widgets/isitbooming_heading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final loader = const SpinKitFoldingCube(
    color: Colors.white,
  );

  late BoomFeedCubit _boomFeedCubit;

  @override
  void initState() {
    //Get a reference to the Cubit so it can be referred to safely in the onDestroy function.
    _boomFeedCubit = BlocProvider.of<BoomFeedCubit>(context);

    //Start playong the boom that was playing when the user left the feed page. Only done if the feed_cubit is
    //already initialized meaning that it was a user navigation to another page that caused the pausing of
    //the current boom.
    if (_boomFeedCubit.isInitialized) {
      _boomFeedCubit.playCurrentPlayer();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoomFeedCubit, FeedState>(
      builder: (context, data) => Stack(
        children: [
          data is LoadedFeedState
              ? PageView.builder(
                  controller:
                      PageController(initialPage: _boomFeedCubit.currentPlayingBoomIndex),
                  itemCount: data.feed.length,
                  onPageChanged: (newIndex) =>
                      _boomFeedCubit.reportScroll(newIndex),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => FeedItem(data.feed[index]),
                )
              : Container(
                  color: Colors.black,
                  child: Center(
                    child: loader,
                  ),
                ),
          const IsItBoomingHeading(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print('Feed page disposed');

    //Pause the currently playing video player
    _boomFeedCubit.pauseCurrentPlayer();

    super.dispose();
  }
}
