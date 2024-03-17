//Class which handles the collection of data regarding the 'My Booms' section of the Dashboard page.
import 'dart:convert';

import 'package:sandbox/features/dashboard/data/data_providers/my_booms_provider.dart';
import 'package:sandbox/features/dashboard/data/models/boom_thumbnail.dart';

class MyBoomsRepository {
  final myBoomsProvider = MyBoomsProvider();

  MyBoomsRepository();

  Future<List<BoomThumbnail>> getBoomThumbnails() async {
    List<BoomThumbnail> temp = [];

    //Fetch the thumbnails from the API
    String rawResponse = await myBoomsProvider.getMyBooms();

    List<dynamic> decodedJson = jsonDecode(rawResponse);

    for (var i = 0; i < decodedJson.length; i++) {
      temp.add(BoomThumbnail.fromJson(decodedJson[i]));
    }

    return temp;
  }
}
