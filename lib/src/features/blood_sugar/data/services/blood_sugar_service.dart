import 'dart:convert';

import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodSugarService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<StreamedResponse> saveBloodSugar_(dynamic data) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final userId = {'user_id': id};
    Map<String, dynamic> mergedData = {...data, ...userId};
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
      final response = await call(saveBloodSugar_, data);
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
}
