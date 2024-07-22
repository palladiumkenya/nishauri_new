import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nishauri/src/features/auth/data/respositories/credential_storage_repository.dart';

class BiometricAuthService {
  static final _auth = LocalAuthentication();
  final credentialStorage = CredentialStorageRepository();

  Future<bool> canCheckBiometrics() async {
    try {
      // Check if we can check biometrics
      return await _auth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  Future<bool> hasSavedBiometrics() async {
    final credentials = await credentialStorage.fetchCredentials();
    return credentials['username'] != '' && credentials['password'] != '';
  }

  Future<bool> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException catch (e) {
      return false;
    }
    return authenticated;
  }
}
