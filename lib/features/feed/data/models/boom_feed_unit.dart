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

  //Initialize the first three booms and play the first video
  Future<BoomFeedUnit> initializeUnit() async {
    for (var i = 0; i < 3; i++) {
      await booms[i].controller.initialize();
    }

    await booms[0].controller.play();

    return this;
  }

  //n = currentIndex
  //Play the next boom in the Boom Feed Unit
  void playNextBoom() {
    //Pause the boom at n
    pause(currentIndex);
    //Play the next boom
    play(currentIndex + 1);
    //Dispose of the n - 2 controller
    if (currentIndex >= 2) {
      disposeOfController(currentIndex - 2);
    }
    //Initialize the boom at n + 3 (n = currentIndex)
    if (currentIndex <= unitSize - 3) {
      initializeController(currentIndex + 3);
    }

    currentIndex++;
  }

  //Play the previous boom in the Boom Feed Unit
  void playPreviousBoom() {
    //Pause the boom at n
    pause(currentIndex);
    //Play the previous boom (n - 1)
    play(currentIndex - 1);
    //Dispose of the n + 2 controller
    disposeOfController(currentIndex + 2);
    //Initialize the boom at n - 3
    if (currentIndex >= 3) {
      initializeController(currentIndex - 3);
    }

    currentIndex--;
  }

  //Pause a in this Boom Feed Unit
  void pause(int index) {
    booms[index].controller.pause();
  }

  //Play a video in this Boom Feed Unit
  void play(int index) {
    booms[index].controller.play();
  }

  //Pause the currently playing video in this Boom Feed Unit
  void pauseCurrent() {
    booms[currentIndex].controller.pause();
  }

  //Play the currently playing video in this Boom Feed Unit
  void playCurrent() {
    booms[currentIndex].controller.play();
  }

  void disposeOfController(int index) {
    booms[index].controller.dispose();
  }

  Future initializeController(int index) async {
    booms[index].initialize();
  }
}
