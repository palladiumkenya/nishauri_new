import 'dart:convert';

import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/hiv/data/models/address/address.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

import '../../../../utils/constants.dart';

class ARTEventsService extends HTTPService {

  Future<List<ARTEvent>> getUserRelatedEvents() async {
    final response = await call(getUserRelatedEvents_, null);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> programData = json.decode(responseString);
    final programs = (programData["results"] as List<dynamic>)
        .map((e) => ARTEvent.fromJson(e))
        .toList();
    return programs;
  }

  Future<StreamedResponse> getUserRelatedEvents_(dynamic args) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request = Request(
        'GET',
        Uri.parse(
            '${Constants.BASE_URL}/hiv-program/art-community/events'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
