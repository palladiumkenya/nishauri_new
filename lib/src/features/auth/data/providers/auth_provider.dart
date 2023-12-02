import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/auth/presentation/controllers/auth_controller.dart';

// 1. Api service provider
final authServiceProvider = Provider<AuthApiService>((ref) => AuthApiService());

// 2. Repository provider
final authRepoProvider = Provider<AuthRepository>(
    (ref) => AuthRepository(ref.watch(authServiceProvider)));

// 3. General auth provider(View model provider)
final authStateProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref.read(authRepoProvider));
});
