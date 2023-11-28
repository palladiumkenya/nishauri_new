import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';

class AuthRepository {
  final AuthApiService _service;

  AuthRepository(this._service);

  Future<AuthState> authenticate(Map<String, dynamic> credentials) async {
    final response = await _service.authenticate(credentials);
    return response;
  }

  Future<AuthState> register(Map<String, dynamic> data) async {
    final response = await _service.register(data);
    return response;
  }
  Future<bool> verifyAccount(Map<String, dynamic> data) async {
    final response = await _service.accountVerify(data);
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
