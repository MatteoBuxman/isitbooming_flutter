import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/core/feed/feed_controller.dart';
import 'package:sandbox/features/feed/business_logic/boom_feed_cubit.dart';
import 'package:sandbox/features/feed/presentation/widgets/feed_scroll.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  late BoomFeedCubit _boomFeedCubit;

  @override
  void initState() {
    //Get a reference to the Cubit so it can be referred to safely in the onDestroy function.
    _boomFeedCubit = BlocProvider.of<FeedController>(context) as BoomFeedCubit;

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
    return FeedScroll(controllingCubit: _boomFeedCubit,);
  }

  @override
  void dispose() {
    print('Feed page disposed');

    //Pause the currently playing video player
    _boomFeedCubit.reportUserClickAway();

    super.dispose();
  }
}
