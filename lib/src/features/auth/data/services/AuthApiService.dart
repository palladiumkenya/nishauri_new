import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class AuthApiService extends HTTPService {
  var headers = {'Content-Type': 'application/json'};

  Future<AuthState> _authenticate(Map<String, dynamic> credentials) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL}signin'));
    request.body = json.encode(credentials);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final data = jsonDecode(responseString);
      if (data["success"]) {
        final authState = AuthState.fromResponse(
            token: data["data"]["token"], user: data["data"]["user_id"]);
        return authState;
      }
      throw await getExceptionFromString(data["msg"]);
    } else {
      throw await getException(response);
    }
  }

  Future<AuthState> authenticate(Map<String, dynamic> credentials) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL}/auth/login'));
    request.body = json.encode(credentials);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final data = jsonDecode(responseString);
      final authState = AuthState.fromResponse(
        token: response.headers["x-access-token"]!,
        refresh: response.headers["x-refresh-token"]!,
        isAccountVerified: data["user"]["accountVerified"]!,
        isProfileComplete: data["user"]["profileUpdated"]!,
      );
      return authState;
    } else {
      throw await getException(response);
    }
  }

  Future<AuthState> _register(Map<String, dynamic> data) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL}signup'));
    request.body = json.encode(data);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final data = jsonDecode(responseString);
      if (data["success"]) {
        final authState = AuthState.fromResponse(token: '');
        return authState;
      }
      throw await getExceptionFromString(data["msg"]);
    } else {
      throw await getException(response);
    }
  }

  Future<AuthState> register(Map<String, dynamic> data) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL}/auth/register'));
    request.body = json.encode(data);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      final responseString = await response.stream.bytesToString();
      final data = jsonDecode(responseString);
      final authState = AuthState.fromResponse(
        token: response.headers["x-access-token"]!,
        refresh: response.headers["x-refresh-token"]!,
        isAccountVerified: data["user"]["accountVerified"]!,
        isProfileComplete: data["user"]["profileUpdated"]!,
      );
      return authState;
    } else {
      throw await getException(response);
    }
  }
}
