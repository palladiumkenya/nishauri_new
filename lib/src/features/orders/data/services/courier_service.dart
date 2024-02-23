import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/features/orders/data/models/courier/courier.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

import '../../../../utils/constants.dart';

class CourierService extends HTTPService {
  final _couriers = [
    const Courier(id: "1", name: "Boda boda"),
    const Courier(id: "2", name: "boat service"),
    const Courier(id: "3", name: "air service"),
    const Courier(id: "4", name: "Glovo"),
  ];

  Future<List<Courier>> getCourierServices () async {
    final response = await call(getCourierServices_, null);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> programData = json.decode(responseString);
    final programs = (programData["results"] as List<dynamic>)
        .map((e) => Courier.fromJson(e))
        .toList();
    return programs;
  }

  Future<StreamedResponse> getCourierServices_(dynamic args) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request = Request('GET',
        Uri.parse('${Constants.BASE_URL}/hiv-program/orders/courier-services'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
