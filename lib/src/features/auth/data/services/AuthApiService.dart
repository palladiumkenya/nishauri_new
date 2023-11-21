import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class AuthApiService extends HTTPService {
  var headers = {'Content-Type': 'application/json'};

  Future<AuthState> authenticate(String username, String password) async {
    final authState = AuthState(token: "token");
    return authState;
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL}auth/login'));
    request.body = json.encode({"username": username, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return authState.copyWith(token: response.headers["x-auth-token"]!);
    } else {
      throw await getException(response);
    }
  }

  Future<AuthState> register(String username, String phoneNumber, String password,
      String confirmPassword, String email) async {
    final authState = AuthState();
    return authState;
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL}auth/register'));
    request.body = json.encode({
      "username": username,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "confirmPassword": confirmPassword
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return authState.copyWith(token: response.headers['token']!);
    } else {
      throw await getException(response);
    }
  }
}
