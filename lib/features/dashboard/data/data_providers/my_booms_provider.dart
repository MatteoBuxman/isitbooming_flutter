import 'dart:io';

//Class which executes requests for the booms to be displayed in a user's 'My Booms' page on their dashboard.
class MyBoomsProvider {
  MyBoomsProvider();

  Future<String> getMyBooms() async {
    // Response<dynamic> response = await _dioClient
    //     .get(_myBoomsEndpoint);

    // return response.data;

    //Simulate network latency
    await Future.delayed(const Duration(seconds: 3));

    return File(
            '/Users/matteobuxman/Desktop/Code/app-development/sandbox/lib/features/dashboard/data/data_providers/mock_dashboard_grid.json')
        .readAsString();
  }
}
