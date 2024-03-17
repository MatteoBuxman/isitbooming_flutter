//Matteo Buxman
//08-03-2024

//A class which acts as state for the user feed
import 'package:sandbox/features/feed/data/models/boom.dart';

enum FetchStatus {
  success,
  error;
}

//The class which represents a list of (maximum of 10) booms in the user's feed page. Handles preloading, pausing, and playing as the user scrolls within that list of booms.
class BoomFeedUnit {
  static const int maxBoomUnitSize = 0;
  //The fetch status of the FeedUnit. If there was an error fetching it from the network, this is indicated here.
  final FetchStatus fetchStatus;
  //List of BoomFeedUnit
  final List<Boom> booms;
  //How many booms are held in the unit
  final int unitSize;

  //Whether or not the current unit is being viewed in the feed
  bool isFocused;

  //Variable which contains the index of the currently playing boom
  int currentIndex = 0;

  BoomFeedUnit(this.booms,
      {this.isFocused = false, this.fetchStatus = FetchStatus.success})
      : unitSize = booms.length;

  //The constructor for the case where the network fetch for the feed unit failed.
  factory BoomFeedUnit.fetchFailed() {
    return BoomFeedUnit(List.empty(), fetchStatus: FetchStatus.error);
  }

  //Constructor to construct a feed unit from an array of Boom information
  factory BoomFeedUnit.createUnitFromJSON(List<dynamic> boomData) {
    final boomList = <Boom>[];

    for (int i = 0; i < boomData.length; i++) {
      boomList.add(Boom.fromJson(boomData[i]));
    }

    return BoomFeedUnit(boomList);
  }
}
