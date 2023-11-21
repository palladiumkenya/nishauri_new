import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';

class AuthRepository {
  final AuthApiService _service;

  AuthRepository(this._service);

  Future<AuthState> authenticate(String username, String password) async {
    final response = await _service.authenticate(username, password);
    return response;
  }

  Future<AuthState> register(String username, String phoneNumber, String password,
      String confirmPassword,String email) async {
    final response = await _service.register(
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
