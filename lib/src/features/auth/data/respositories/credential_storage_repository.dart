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

  Future<void> saveBiometricPreference(bool enabled) async {
    try {
      await _storage.write(key: 'biometricEnabled', value: enabled.toString());
    } catch (e) {
      debugPrint("Error saving biometric preference: $e");
      throw e;
    }
  }

  Future<bool> fetchBiometricPreference() async {
    try {
      final String? isEnabled = await _storage.read(key: 'biometricEnabled');
      return isEnabled == 'true';
    } catch (e) {
      debugPrint("Error fetching biometric preference: $e");
      return false;
    }
  }



  // delete credentials
  Future<void> deleteCredentials() async {
    try {
      await _storage.delete(key: 'username');
      await _storage.delete(key: 'password');
    } catch (e) {
      debugPrint("Error deleting credentials: $e");
      throw e;
    }
  }
}
