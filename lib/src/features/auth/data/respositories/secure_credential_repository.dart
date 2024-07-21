import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveCredentials(String phone_number, String password) async {
    await _storage.write(key: 'phone_number', value: phone_number);
    await _storage.write(key: 'password', value: password);
  }

  Future<Map<String, String>> fetchCredentials() async {
    String? phone_number = await _storage.read(key: 'phone_number');
    String? password = await _storage.read(key: 'password');
    return {
      'phone_number': phone_number ?? '',
      'password': password ?? '',
    };
  }
}
