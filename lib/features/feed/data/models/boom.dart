import 'package:sandbox/features/feed/data/models/location.dart';
import 'package:video_player/video_player.dart';

class Boom {
  final String boomID;
  final String postTime;
  final String userUUID;
  final String username;
  final String userProfilePhotoURL;
  final Location location;
  final bool isSaved;
  final bool isHyped;
  final String videoURL;

  //The video controller for the boom
  VideoPlayerController controller;

  Boom({
    required this.boomID,
    required this.postTime,
    required this.userUUID,
    required this.username,
    required this.userProfilePhotoURL,
    required this.location,
    required this.isSaved,
    required this.isHyped,
    required this.videoURL,
  }) : controller = VideoPlayerController.networkUrl(Uri.parse(videoURL));

  factory Boom.fromJson(Map<String, dynamic> json) {
    return Boom(
      boomID: json['boomID'],
      postTime: json['postTime'],
      userUUID: json['userUUID'],
      username: json['username'],
      userProfilePhotoURL: json['userProfilePhotoURL'],
      location: Location.fromJson(json['location']),
      isSaved: json['isSaved'] == 'True',
      isHyped: json['isHyped'] == 'True',
      videoURL: json['videoURL'],
    );
  }

  //Reinitialize a boom that has previously been disposed
  void initialize() {
    controller = VideoPlayerController.networkUrl(Uri.parse(videoURL));
    controller.initialize();
  }
}
