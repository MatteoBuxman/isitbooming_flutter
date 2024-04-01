//Class which handles the collection of data regarding the 'My Booms' section of the Dashboard page.

import 'dart:convert';

import 'package:sandbox/features/dashboard/data/data_providers/my_booms_provider.dart';
import 'package:sandbox/features/dashboard/data/errors/boom_list_fetch_exception.dart';
import 'package:sandbox/features/feed/data/models/boom.dart';

class MyBoomsRepository {
  final myBoomsProvider = MyBoomsProvider();

  MyBoomsRepository();

  Future<List<Boom>> getUserDashboard() async {
    try {
      final rawData = await myBoomsProvider.getMyBooms();

      final parsedJson = jsonDecode(rawData);

      //Check to see the status of the request. A errorCode of 0 is nominal.
      if (parsedJson['errorCode'] as int != 0) {
        throw BoomListFetchException(
            "There was error with our backend services",
            errorCode: parsedJson['errorCode'] as int);
      }

      final booms = parsedJson['booms'];

      final List<Boom> returnArr = [];

      for (var boom in booms) {
        returnArr.add(Boom.fromJson(boom));
      }

      return returnArr;

    } catch (e) {
      throw BoomListFetchException(e.toString());
    }
  }
}
