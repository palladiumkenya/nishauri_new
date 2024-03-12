import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/respositories/UserRepository.dart';
import 'dart:developer' as developer;

class UserController extends StateNotifier<AsyncValue<User>> {
  final UserRepository _repository;

  UserController(this._repository) : super(const AsyncValue.loading()) {
    getUser();
  }

  Future<void> getUser() async {
    state = const AsyncValue.loading();
    try {
      User user = await _repository.getUser();
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      developer.log('-->getUser ${e.toString()}');
      rethrow;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final user_ = await _repository.updateProfile(user);
      await getUser();
    } catch (e) {
      developer.log('-->updateUser ${e.toString()}');
      rethrow;
    }
  }

  Future<String> verify(Map<String, dynamic> data) async {
    try {
      return await _repository.verifyAccount(data);
    } catch (e) {
      developer.log('-->Verify ${e.toString()}');
      rethrow;
    }
  }
  Future<String> getOTPCode(String mode) async {
    try {
      return await _repository.getOTPCode(mode);
    } catch (e) {
      developer.log('-->getOTPCode ${e.toString()}');
      rethrow;
    }
  }
}
