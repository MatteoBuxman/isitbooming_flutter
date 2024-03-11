import 'package:sandbox/features/feed/data/models/boom.dart';

class FeedState{}

class LoadingFeedState extends FeedState{}

class LoadedFeedState extends FeedState {
  final List<Boom> feed;
  //The index of the boom within the unit that is currently playing
  final int currentPlayingBoomIndex;

  LoadedFeedState(this.feed, this.currentPlayingBoomIndex);
}



