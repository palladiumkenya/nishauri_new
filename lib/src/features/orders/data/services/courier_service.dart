import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/orders/data/models/courier/courier.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

import '../../../../utils/constants.dart';

class CourierService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
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
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/courier_services';
    final response = request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);
    return response;
    // var request = Request('GET',
    //     Uri.parse('${Constants.BASE_URL_NEW}/courier_services'));
    // request.headers.addAll(headers);
    // return await request.send();
  }
}
