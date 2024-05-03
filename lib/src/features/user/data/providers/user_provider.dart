import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/models/reset_password.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/data/respositories/reseet_password_repository.dart';
import 'package:nishauri/src/features/auth/data/services/ResetPassword.dart';
import 'package:nishauri/src/features/auth/presentation/controllers/reset_password_controller.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/respositories/UserRepository.dart';
import 'package:nishauri/src/features/user/data/services/UserService.dart';
import 'package:nishauri/src/features/user/presentation/controllers/UserControler.dart';

final userProvider = StateNotifierProvider<UserController, AsyncValue<User>>((ref) {
  final service = UserService();
  final repo = UserRepository(service);
  return UserController(repo);
});

final resetPasswordProvider = StateNotifierProvider<ResetPasswordController, AsyncValue<PasswordReset>>((ref) {
  final service = ResetPasswordService();
  final repo = ResetPasswordRepository(service);
  return ResetPasswordController(repo);
});