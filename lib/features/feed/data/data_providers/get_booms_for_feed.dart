import 'dart:io';

class GetFeedBoomsProvider {
  GetFeedBoomsProvider();

  Future<String> getFeedBooms() async {
        return File('/Users/matteobuxman/Desktop/boom_data.json').readAsString();
  }
}
