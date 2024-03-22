import 'dart:convert';

import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class ARTDrugOrderService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());

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
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final userId = {'user_id': id};
    var mergedData = {...data, ...userId};
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var request = Request(
      'POST',
      Uri.parse('${Constants.BASE_URL_NEW}/create_order'),
    );
    request.body = json.encode(mergedData);
    request.headers.addAll(headers);
    print(request.body);
    return await request.send();
  }

  // Future<ARTDrugOrder> createOrder(Map<String, dynamic> data) async {
  //   final response = await call<Map<String, dynamic>>(createOrder_, data);
  //   final responseString = await response.stream.bytesToString();
  //   final Map<String, dynamic> orderData = json.decode(responseString);
  //   return ARTDrugOrder.fromJson(orderData);
  // }

  Future<String> createOrder(Map<String, dynamic> data) async {
    try {
      final response = await call<Map<String, dynamic>>(createOrder_, data);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> orderData = json.decode(responseString);
        if (orderData["success"] == true){
          return orderData["msg"];
        } else {
          throw orderData["msg"];
        }
      } else {
        throw "Something Went Wrong Contact Try Again";
      }
    } catch (e) {
      throw e.toString();
    }
    // return ARTDrugOrder.fromJson(orderData);
  }
}
