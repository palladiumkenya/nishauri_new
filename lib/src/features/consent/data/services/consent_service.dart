import 'dart:convert';

import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/consent/data/models/consent.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class ConsentService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<String> consent() async {
    try {
      final response = await call(consent_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final resp = json.decode(responseString);
        if (resp["success"] == false) {
          return resp["msg"];
        } else {
          throw resp["msg"];
        }
      }
    } catch (e) {
      throw e;
    }
    return "";
  }

  Future<StreamedResponse> consent_(dynamic data) async {
    final id = await _repository.getUserId();
    final userId = {"user_id": id};
    final tokenPair = await getCachedToken();
    final headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var url = '${Constants.BASE_URL_NEW}/chat_consent';
    final response = request(
        url: url,
        token: tokenPair,
        method: 'POST',
        requestHeaders: headers,
        userId: id,
        data: userId);
    return response;
  }

  Future<String> revokeConsent() async {
    try {
      final response = await call(revokeConsent_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final resp = json.decode(responseString);
        if (resp["success"] == false) {
          return resp["msg"];
        } else {
          throw resp["msg"];
        }
      }
    } catch (e) {
      throw e;
    }
    return "";
  }

  Future<StreamedResponse> revokeConsent_(dynamic args) async {
    final id = await _repository.getUserId();
    final userId = {"user_id": id};
    final tokenPair = await getCachedToken();
    final headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var url = '${Constants.BASE_URL_NEW}/chat_consent';
    final response = request(
        url: url,
        token: tokenPair,
        method: 'POST',
        requestHeaders: headers,
        userId: id,
        data: userId);
    return response;
  }

  Future<List<Consent>> getConsent() async {
    try {
      final response = await call(getConsent_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final resp = json.decode(responseString);
        if (resp["success"] == true) {
          final data = resp["data"];
          if (data is List) {
            return data.map((e) => Consent.fromJson(e)).toList();
          } else if (data is Map) {
            return [Consent.fromJson(data as Map<String, dynamic>)];
          } else {
            throw "Unexpected data format";
          }
        } else {
          throw resp["msg"];
        }
      } else {
        throw "Failed to fetch consent";
      }
    } catch (e) {
      throw e;
    }
  }

  Future<StreamedResponse> getConsent_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var url = '${Constants.BASE_URL_NEW}/get_chat_consent?user_id=$id';
    final response = request(
        url: url,
        token: tokenPair,
        method: 'GET',
        requestHeaders: headers,
        userId: id);
    return response;
  }
}
