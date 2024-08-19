import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodSugarService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<StreamedResponse> saveBloodSugar_(BloodSugar data) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final userId = {'user_id': id};
    var mergedData = {...data.toJson(), ...userId};
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/blood_sugar';
    final response = request(
        url: url,
        token: tokenPair,
        method: 'POST',
        requestHeaders: headers,
        data: mergedData,
        userId: id);
    return response;
  }

  Future<String> saveBloodSugar(dynamic data) async {
    try {
      final response = await call<BloodSugar>(saveBloodSugar_, data);
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

  Future<StreamedResponse> fetchBloodSugars_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var url = '${Constants.BASE_URL_NEW}get_blood_sugar?user_id=$id';
    final response = request(
        url: url,
        token: tokenPair,
        method: 'GET',
        requestHeaders: headers,
        userId: id);
    return response;
  }

  Future<List<BloodSugar>> fetchBloodSugars() async {
    try {
      final response = await call(fetchBloodSugars_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> responseData = json.decode(responseString);

        if (responseData.containsKey('data')) {
          final orderData = responseData['data'];
          debugPrint("Blood Sugar Data: $orderData");

          if (orderData is Map && orderData.containsKey('blood_sugar')) {
            final bloodSugarList = orderData['blood_sugar'];
            if (bloodSugarList is List) {
              List<BloodSugar> bloodSugars = [];
              bloodSugarList.forEach((element) {
                bloodSugars.add(BloodSugar.fromJson(element));
              });
              return bloodSugars;
            } else {
              throw "Blood sugar data is not a list";
            }
          } else {
            throw "Data does not contain blood sugar list";
          }
        } else {
          throw "Invalid response format";
        }
      } else {
        throw "Something Went Wrong Try Again Later ${response.statusCode}";
      }
    } catch (e) {
      throw "$e";
    }
  }
}
