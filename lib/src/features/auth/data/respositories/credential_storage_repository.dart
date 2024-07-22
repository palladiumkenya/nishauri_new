import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';

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

  Future<void> saveBiometricPreference(bool isEnabled) async {
    await _storage.write(key: 'biometricEnabled', value: isEnabled.toString());
  }

  Future<bool> fetchBiometricPreference() async {
    final String? isEnabled = await _storage.read(key: 'biometricEnabled');
    if (isEnabled == 'true') {
      return true;
    } else {
      return false;
    }
  }

  // delete credentials
  Future<void> deleteCredentials() async {
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'password');
    debugPrint('Credentials deleted');
  }
}
