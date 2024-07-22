import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/respositories/credential_storage_repository.dart';

final biometricPreferenceProvider = FutureProvider<bool>((ref) async {
  final credentialStorage = CredentialStorageRepository();
  return await credentialStorage.fetchBiometricPreference();
});
