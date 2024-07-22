import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialStorageRepository {
  final _storage = const FlutterSecureStorage();

  Future<void> saveCredentials(String username, String password) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
  }

  Future<Map<String, String>> fetchCredentials() async {
    String? username = await _storage.read(key: 'username');
    String? password = await _storage.read(key: 'password');
    return {
      'username': username ?? '',
      'password': password ?? '',
    };
  }
}
