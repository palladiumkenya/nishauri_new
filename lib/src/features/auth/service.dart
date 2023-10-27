import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/utils/constants.dart';

class AuthApiService {
  Future<http.Response> login(Map<String, dynamic> credentials) async {
    final endpoint = Uri.parse("${Constants.BASE_URL}auth/login");
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(endpoint,
        headers: headers, body: jsonEncode(credentials));
    return response;
  }
}

