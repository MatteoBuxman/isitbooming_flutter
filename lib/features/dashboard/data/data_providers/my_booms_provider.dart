import 'dart:io';



//Class which executes requests for the booms to be displayed in a user's 'My Booms' page on their dashboard.
class MyBoomsProvider {

  MyBoomsProvider();

  Future<String> getMyBooms() async {
    try {
      // Response<dynamic> response = await _dioClient
      //     .get(_myBoomsEndpoint);

      // return response.data;

      return File(
              '/Users/matteobuxman/Desktop/Code/app-development/sandbox/lib/features/dashboard/data/data_providers/thumbnail_response.json')
          .readAsString();
    } catch (e) {
      return "Error Fetching Boom Data";
    }
  }
}
