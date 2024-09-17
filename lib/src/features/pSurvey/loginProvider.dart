import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  LoginNotifier() : super(const AsyncValue.data(null));

  // Function to make the login request
  Future<void> login() async {
    final String url = 'https://psurveyapitest.kenyahmis.org/auth/token/login';
    final String msisdn = '0712311264';
    final String password = '12345678';

    final body = jsonEncode({
      'msisdn': msisdn,
      'password': password,
    });

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
    };

    state = const AsyncValue.loading();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('auth_token')) {
          final String authToken = data['auth_token'];

          // Save the auth token
          // Save the auth token in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', authToken);
          print('Auth token saved: $authToken');
          //print('Login successful. Auth token: $authToken');
          state = const AsyncValue.data(null);
        } else {
          throw Exception('Login failed');
        }
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
