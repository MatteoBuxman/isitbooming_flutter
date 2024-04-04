//Class which represents an event in the user's dashboard

import 'package:sandbox/features/feed/data/models/location.dart';

class Event {
  String eventName, eventDescription;
  bool hasPassed;
  Location location;
  DateTime startTime;
  DateTime endTime;
  List<dynamic> furtherInformationLinks;

  Event(
      {
      required this.eventName,
      required this.eventDescription,
      required this.hasPassed,
      required this.location,
      required this.startTime,
      required this.endTime,
      //The paths of the data of the screens that appear when clicking on the event card. Eg 'See Booms' and 'Who's coming'.
      required this.furtherInformationLinks});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventName: json['eventName'],
      eventDescription: json['eventDescription'],
      hasPassed: json['hasPassed'],
      location: Location.fromJson(json['location']),
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      furtherInformationLinks: json['furtherInformationLinks'],
    );
  }
}
