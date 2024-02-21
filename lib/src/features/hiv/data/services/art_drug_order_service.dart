import 'dart:convert';

import 'package:http/http.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class ARTDrugOrderService extends HTTPService {
  Future<StreamedResponse> getOrders_(dynamic args) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request = Request(
      'GET',
      Uri.parse('${Constants.BASE_URL}/patients/programs/patient-programs'),
    );
    request.headers.addAll(headers);
    return await request.send();
  }

  Future<List<ARTDrugOrder>> getOrders() async {
    final response = await call(getOrders_, null);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> programData = json.decode(responseString);
    final programs = (programData["results"] as List<dynamic>)
        .map((e) => ARTDrugOrder.fromJson(e))
        .toList();
    return programs;
  }

  Future<StreamedResponse> createOrder_(Map<String, dynamic> data) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request = Request(
      'POST',
      Uri.parse('${Constants.BASE_URL}/patients/programs/patient-programs'),
    );
    request.body = json.encode(data);
    request.headers.addAll(headers);
    return await request.send();
  }

  Future<ARTDrugOrder> createOrder(Map<String, dynamic> data) async {
    final response = await call<Map<String, dynamic>>(createOrder_, data);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> orderData = json.decode(responseString);
    return ARTDrugOrder.fromJson(orderData);
  }
}
