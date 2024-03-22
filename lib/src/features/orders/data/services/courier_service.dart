import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/features/orders/data/models/courier/courier.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

import '../../../../utils/constants.dart';

class CourierService extends HTTPService {
  // final _couriers = [
  //   const Courier(id: "1", name: "Boda boda"),
  //   const Courier(id: "2", name: "boat service"),
  //   const Courier(id: "3", name: "air service"),
  //   const Courier(id: "4", name: "Glovo"),
  // ];

  Future<List<Courier>> getCourierServices () async {
    try {
      final response = await call(getCourierServices_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> programData = json.decode(responseString);
        final programs = (programData["data"] as List<dynamic>)
            .map((e) => Courier.fromJson(e))
            .toList();
        return programs;
      } else {
        throw "Something Went Wrong Contact Try Again";
      }
    } catch (e) {
      throw "Please check your internet connection";
    }
  }

  Future<StreamedResponse> getCourierServices_(dynamic args) async {
    final tokenPair = await getCachedToken();
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var request = Request('GET',
        Uri.parse('${Constants.BASE_URL_NEW}/courier_services'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
