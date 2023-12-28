import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/respositories/UserRepository.dart';
import 'package:nishauri/src/features/user/data/services/UserService.dart';
import 'package:nishauri/src/features/user/presentation/controllers/UserControler.dart';

final userProvider = StateNotifierProvider<UserController, AsyncValue<User>>((ref) {
  final authState = ref.read(authStateProvider.notifier);
  final service = UserService(authState.token);
  final repo = UserRepository(service);
  return UserController(repo);
});
