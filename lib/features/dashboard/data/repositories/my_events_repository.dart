//Class which handles the collection of data regarding the 'My Booms' section of the Dashboard page.

import 'dart:convert';

import 'package:sandbox/features/dashboard/data/data_providers/my_events_provider.dart';
import 'package:sandbox/features/dashboard/data/exceptions/boom_list_fetch_exception.dart';
import 'package:sandbox/features/dashboard/data/exceptions/event_list_fetch_exception.dart';
import 'package:sandbox/features/dashboard/data/models/event.dart';

class MyEventsRepository {
  final myEventsProvider = MyEventsProvider();

  MyEventsRepository();

  Future<Map<String, List<Event>>> getUserEvents() async {
    try {
      final rawData = await myEventsProvider.getMyEvents();

      final parsedJson = jsonDecode(rawData);

      //Check to see the status of the request. A errorCode of 0 is nominal.
      if (parsedJson['errorCode'] as int != 0) {
        throw BoomListFetchException(
            "There was an error with our backend services",
            errorCode: parsedJson['errorCode'] as int);
      }

      final currentEventsJson = parsedJson['currentEvents'];
      final pastEventsJson = parsedJson['previousEvents'];

      final List<Event> currentEvents = [];
      final List<Event> pastEvents = [];

      //Handle current events
      for (var event in currentEventsJson) {
        currentEvents.add(Event.fromJson(event));
      }

      //Handle past events
      for (var event in pastEventsJson) {
        pastEvents.add(Event.fromJson(event));
      }

      return {
        'currentEvents': currentEvents,
        'pastEvents': pastEvents,
      };

    } on EventListFetchException {
      rethrow;
    } catch (e) {
      throw EventListFetchException(e.toString());
    }
  }
}
