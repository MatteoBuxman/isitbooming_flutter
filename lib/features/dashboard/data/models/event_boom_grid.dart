import 'package:sandbox/features/feed/data/models/boom.dart';

class EventBoomGrid {
  final String eventName;
  final List<Boom> booms;

  EventBoomGrid(this.eventName, this.booms);

  factory EventBoomGrid.fromJSON(String eventTitle, List<dynamic> json) {
    final List<Boom> temp = [];
    for (var eventBoom in json) {
      temp.add(Boom.fromJson(eventBoom));
    }

    return EventBoomGrid(eventTitle, temp);
  }
}
