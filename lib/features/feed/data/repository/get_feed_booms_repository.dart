import 'dart:convert';

import 'package:sandbox/features/feed/data/data_providers/get_booms_for_feed.dart';
import 'package:sandbox/features/feed/data/models/boom_feed_unit.dart';

class GetFeedBoomsRepository {
  //Data provider for the repository
  final boomProvider = GetFeedBoomsProvider();
  //Integer to track how many times this instance has been used to access a feed unit.
  int callAmount = 0;

  Future<BoomFeedUnit> requestFeedUnit() async {
    try {
      //A json string representing the response from the backend API providing the booms to show
      final apiResponse = await boomProvider.getFeedBooms();

      //Parse string into an object
      final decodedApiResponse = jsonDecode(apiResponse);

      //Select the 'booms' key from the json response
      final boomJsonArray = decodedApiResponse['booms'];

      //Increment callAmount
      callAmount++;

      //Return a BoomFeedUnit
      return BoomFeedUnit.createUnitFromJSON(boomJsonArray);
    } catch (identifier) {
      //Return a failed state Boom Unit
      return BoomFeedUnit.fetchFailed();
    }
  }
}
