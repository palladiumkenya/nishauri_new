import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/utils/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AuthApiService {
  Future<http.Response> login(credentials) async {
    final endpoint = Uri.parse("${Constants.BASE_URL}auth/login");
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(endpoint,
        headers: headers, body: jsonEncode(credentials));
    return response;
  }
}

final authProvider = FutureProvider<AuthApiService>((ref) => AuthApiService());
