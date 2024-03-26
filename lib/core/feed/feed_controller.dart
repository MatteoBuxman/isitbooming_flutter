//The interface that needs to be implemented by any controlling cubit used to handle feed state when vertically scrolling through booms

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/features/feed/business_logic/states/feed_state.dart';

abstract class FeedController extends Cubit<FeedState> {
  
  //The index within the implementing class's array of booms of the currently playing boom
  int currentPlayingBoomIndex = 0;

  FeedController() : super(LoadingFeedState());

  void pauseCurrentPlayer();

  void playCurrentPlayer();

  void reportScroll(int newIndex);
}
