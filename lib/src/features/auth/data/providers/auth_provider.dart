// auth_provider.dart
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';

final tokenProvider = FutureProvider((ref) async {
  await Future.delayed(const Duration(seconds: 5));
  final token = await LocalStorage.getToken();
  return token;
});

final authProvider =
    StateNotifierProvider<AuthController, AsyncValue<String>>((ref) {
  final token = ref.watch(tokenProvider);
  return AuthController(token);
});
