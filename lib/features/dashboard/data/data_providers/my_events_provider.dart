//Provider which fetches the user's events for the 'My Events' tab

import 'dart:io';

class MyEventsProvider {
  MyEventsProvider();

  Future<String> getMyEvents() async {
    // Response<dynamic> response = await _dioClient
    //     .get(_myBoomsEndpoint);

    // return response.data;

    //Simulate network latency
    await Future.delayed(const Duration(seconds: 2));

    return File(
            '/Users/matteobuxman/Desktop/Code/app-development/sandbox/lib/features/dashboard/data/data_providers/mock_events_list.json')
        .readAsString();
  }
}
