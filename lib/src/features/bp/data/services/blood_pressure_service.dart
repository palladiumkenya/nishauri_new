import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/bp/data/models/blood_pressure.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodPressureService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<StreamedResponse> saveBloodPressure_(BloodPressure data) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final userId = {'user_id': id};
    var mergedData = {...data.toJson(), ...userId};
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/blood_pressure';
    final response = request(
        url: url,
        token: tokenPair,
        method: 'POST',
        requestHeaders: headers,
        data: mergedData,
        userId: id);
    return response;
  }

  Future<String>saveBloodPressure(BloodPressure data) async {
    try {
      final response = await call<BloodPressure>(saveBloodPressure_, data);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> orderData = json.decode(responseString);
        if (orderData["success"] == true) {
          return orderData["msg"];
        } else {
          throw orderData["msg"];
        }
      } else {
        throw "Something Went Wrong Try Again Later ${response.statusCode}";
      }
    } catch (e) {
      throw "$e";
    }
  }

  Future<StreamedResponse> fetchBloodPressures_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var url = '${Constants.BASE_URL_NEW}drug_delivery_list?user_id=$id';
    final response = request(
        url: url,
        token: tokenPair,
        method: 'GET',
        requestHeaders: headers,
        userId: id);
    return response;
  }

  Future<List<BloodPressure>> fetchBloodPressures() async {
    List<BloodPressure> bp = [];
    final response = await call(fetchBloodPressures_, null);
    // if (response.statusCode == 200) {
    //   final responseString = await response.stream.bytesToString();
    final String responseString = await rootBundle.loadString('assets/data/dummy_bp_data.json');
      final Map<String, dynamic> responseData = json.decode(responseString);
      final List<dynamic> jsonList = responseData["data"];
      bp.addAll(jsonList.map((json) => BloodPressure.fromJson(json)));
      return bp;
    }
    // else {
    //   throw "Failed to fetch data!";
  //   // }
  // }
}
