import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class CyclesService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<StreamedResponse> postCycles_(Map<String, dynamic> data) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final userId = {'user_id': id};
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/menstrual_cycle';
    final payload = {...data, ...userId};
    debugPrint("Data payload: $payload");

    final response = request(
      url: url,
      token: tokenPair,
      method: 'POST',
      requestHeaders: headers,
      userId: id,
      data: payload,
    );

    return response;
  }

  Future<String> postCycles(Map<String, dynamic> data) async {
    try {
      final response = await call<Map<String, dynamic>>(postCycles_, data);
      debugPrint("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final responseData = jsonDecode(responseString);
        if (responseData["success"] == true) {
          return responseData["msg"];
        } else {
          throw responseData["msg"];
        }
      } else {
        throw "Something Went Wrong Try Again Later ${response.statusCode}";
      }
    } catch (e) {
      debugPrint("Error posting Cycles: $e");
      throw "$e";
    }
  }

  Future<StreamedResponse> fetchCycles_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var url = '${Constants.BASE_URL_NEW}get_menstrual_cycle?user_id=$id';
    final response = request(
      url: url,
      token: tokenPair,
      method: 'GET',
      requestHeaders: headers,
      userId: id,
    );
    return response;
  }

  Future<Map<int, Cycle>> fetchCycles() async {
    final response = await call(fetchCycles_, null);
    try {
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> responseData = json.decode(responseString);
        final cyclesMap = {
          for (var cycle in responseData["data"]["menstrual_cycle"])
            cycle['id'] as int: Cycle.fromJson(cycle)
        };
        debugPrint("Cycles Map: $cyclesMap");
        return cyclesMap;
      } else {
        throw "Something went wrong. Status Code: ${response.statusCode}";
      }
    } catch (e) {
      throw "$e";
    }
  }

  Future<StreamedResponse> putCycles_(
      int cycleId, Map<String, dynamic> data) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final userId = {'user_id': id};
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/update_menstrual_cycle/$cycleId';
    final payload = {...data, ...userId};
    debugPrint("Data payload: $payload");

    final response = request(
      url: url,
      token: tokenPair,
      method: 'PUT',
      requestHeaders: headers,
      userId: id,
      data: payload,
    );

    return response;
  }

  // Created a wrapper that only accepts the data and calls putCycles_ internally
  Future<StreamedResponse> editCycles_(Map<String, dynamic> data,
      {required int cycleId}) {
    return putCycles_(cycleId, data);
  }

  Future<String> putCycles(int cycleId, Map<String, dynamic> data) async {
    try {
      final response = await call<Map<String, dynamic>>(
          (data) => editCycles_(data, cycleId: cycleId), data);
      debugPrint("PUT Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final responseData = jsonDecode(responseString);
        if (responseData["success"] == true) {
          return responseData["msg"];
        } else {
          throw responseData["msg"];
        }
      } else {
        throw 'Failed to update cycle. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      debugPrint("Error updating Cycles: $e");
      throw "$e";
    }
  }

  Future<StreamedResponse> deleteCycle_(int cycleId) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/delete_menstrual_cycle/$cycleId';

    final response = request(
      url: url,
      token: tokenPair,
      method: 'DELETE',
      requestHeaders: headers,
      userId: id,
    );

    return response;
  }

  Future<String> deleteCycle(int cycleId) async {
    try {
      final response = await call<int>(deleteCycle_, cycleId);
      debugPrint("DELETE Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final responseData = jsonDecode(responseString);
        if (responseData["success"] == true) {
          return responseData["msg"];
        } else {
          throw responseData["msg"];
        }
      } else {
        throw "Failed to delete cycle. Status Code: ${response.statusCode}";
      }
    } catch (e) {
      debugPrint("Error deleting Cycle: $e");
      throw "$e";
    }
  }
}
