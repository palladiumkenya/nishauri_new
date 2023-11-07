import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';

class AuthRepository {
  final AuthApiService _authService;

  AuthRepository(this._authService);

  Future<String> authenticate(String username, String password) async {
    final response = await _authService.authenticate(username, password);
    return response;
  }

  Future<String> register(String username, String phoneNumber, String password,
      String confirmPassword,String email) async {
    final response = await _authService.register(
        username, phoneNumber, password, confirmPassword, email);
    return response;
  }

  Future<String> getAuthToken() async {
    final token = await LocalStorage.getToken();
    return token;
  }

  Future<String> saveToken(String token) async {
    await LocalStorage.saveToken(token);
    return token;
  }

  Future<void> deleteToken() async {
    await LocalStorage.deleteToken();
  }
}
