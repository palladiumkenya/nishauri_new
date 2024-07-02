import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'dart:developer' as developer;

class AuthApiService extends HTTPService {
  Future<AuthResponse> authenticate(Map<String, dynamic> credentials) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}/signin'));
      request.body = json.encode(credentials);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final data = jsonDecode(responseString);
        final authState = AuthResponse(
          accessToken: data["data"]?["token"] ?? '',
          refreshToken: data["data"]?["refreshToken"] ?? '',
          accountVerified: data["data"]?["account_verified"] == "1"!,
          profileUpdated: data["data"]?["account_verified"] == "1"!,
          userId: data["data"]?["user_id"]!,
          message: data["msg"]!,
          phoneNumber: data["data"]?["phone_no"]!
        );
        return authState;
      } else {
        developer.log('-->authenticate ${await getException(response)}');
        throw await getException(response);
      }
    } catch (e) {
      // Handle internet errors here
      developer.log('Internet error: $e');
      throw 'Internet error occurred';
    }
  }

  Future<AuthResponse> register(Map<String, dynamic> data) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}/signup'));
    request.body = json.encode(data);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      final responseString = await response.stream.bytesToString();
      final data = jsonDecode(responseString);
      final authState = AuthResponse(
          accessToken: data["data"]?["token"]?? ''!,
          refreshToken: data["data"]?["refreshToken"]?? ''!,
          accountVerified: data["data"]?["account_verified"] == "1"!,
          profileUpdated: data["data"]?["account_verified"] == "1"!,
          userId: data["data"]?["user_id"]!,
          message: data["msg"]!,
          phoneNumber: data["data"]?["phone_no"]!
      );
      return authState;
    } else {
      developer.log('-->register ${await getException(response)}');
      throw await getException(response);
    }
  }

  // Future<http.StreamedResponse> signInWithGoogle_() async {
  //   var request =
  //   http.Request('GET', Uri.parse('${Constants.BASE_URL}/auth/google'));
  //   return await request.send();
  // }
  // Future<User> signInWithGoogle() async {
  //
  // }
}
