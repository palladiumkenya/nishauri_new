import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class AuthApiService extends HTTPService {
  var headers = {'Content-Type': 'application/json'};

  Future<AuthState> authenticate(Map<String, dynamic> credentials) async {

    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL}auth/login'));
    request.body = json.encode(credentials);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final authState = AuthState.fromResponse(token: response.headers["x-auth-token"]!);
      return authState;
    } else {
      throw await getException(response);
    }
  }

  Future<bool> accountVerify(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 3));
    debugPrint("*********************| $data |*****************************");
    return true;
  }

  Future<AuthState> register(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 3));
    return AuthState(token: "token", user: User.fromJson(data), isAccountVerified: false, isProfileComplete: false);
    // -----------------------------------------------------------
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL}auth/register'));
    request.body = json.encode(data);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // await Future.delayed(const Duration(seconds: 5));
      final authState = AuthState.fromResponse(token: response.headers["x-auth-token"]!);
      return authState;
    } else {
      throw await getException(response);
    }
  }
}
