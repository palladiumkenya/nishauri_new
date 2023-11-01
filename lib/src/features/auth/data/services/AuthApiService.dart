import 'package:http/http.dart' as http;
import 'package:nishauri/src/utils/constants.dart';

class AuthApiService {
  var headers = {'Content-Type': 'application/json'};

  Future<String> authenticate(String username, String password) async {
    final response =
        await http.post(Uri.parse('${Constants.BASE_URL}auth/login'),
            body: {
              'username': username,
              'password': password,
            },
            headers: headers);

    if (response.statusCode == 200) {
      final token = response.headers['token'];
      return token!;
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  Future<String> register(String username, String phoneNumber, String password,
      String confirmPassword) async {
    final response =
        await http.post(Uri.parse('${Constants.BASE_URL}auth/register'),
            body: {
              'username': username,
              'phoneNumber': phoneNumber,
              'password': password,
              'confirmPassword': confirmPassword,
            },
            headers: headers);

    if (response.statusCode == 200) {
      // final token = jsonDecode(response.body)['token'];
      final token = response.headers['token'];
      return token!;
    } else {
      throw Exception('Failed to register user');
    }
  }
}
