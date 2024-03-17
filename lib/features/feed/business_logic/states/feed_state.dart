import 'package:sandbox/features/feed/data/models/boom.dart';

class FeedState{}

class LoadingFeedState extends FeedState{}

class LoadedFeedState extends FeedState {
  final List<Boom> feed;
  //The index of the boom within the feed list that playback should start from when the Page View mounts.
  final int initialBoomIndex;

  LoadedFeedState(this.feed, this.initialBoomIndex);
}



