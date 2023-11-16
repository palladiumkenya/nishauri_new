import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/respositories/UserRepository.dart';
import 'package:nishauri/src/features/user/data/services/UserService.dart';
import 'package:nishauri/src/features/user/presentation/controllers/UserControler.dart';

final userProvider = StateNotifierProvider<UserController, AsyncValue<User?>>((ref) {
  final token = ref.watch(authStateProvider);
  final service = UserService();

  final repo = UserRepository(service, token);
  return UserController(repo);
});
