import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/utils/constants.dart';

class AuthRepository {
  final http.Client _httpClient;

  AuthRepository(this._httpClient);

  Future<String> authenticate(String username, String password) async {
    final response = await _httpClient.post(
      Uri.parse('${Constants.BASE_URL}auth/login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final token = response.headers['token'];
      return token!;
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  Future<String> register(String username, String phoneNumber, String password,
      String confirmPassword) async {
    final response = await _httpClient.post(
      Uri.parse('${Constants.BASE_URL}auth/register'),
      body: {
        'username': username,
        'phoneNumber': phoneNumber,
        'password': password,
        'confirmPassword': confirmPassword,
      },
    );

    if (response.statusCode == 200) {
      // final token = jsonDecode(response.body)['token'];
      final token = response.headers['token'];
      return token!;
    } else {
      throw Exception('Failed to register user');
    }
  }
}
