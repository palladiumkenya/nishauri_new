import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/respositories/UserRepository.dart';

class UserController extends StateNotifier<AsyncValue<User>> {
  final UserRepository _repository;

  UserController(this._repository) : super(const AsyncValue.loading()){
    getUser();
  }

  Future<void> getUser() async {
    state = const AsyncValue.loading();
    try {
      User user = await _repository.getUser();
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateUser(User user) async {
    state = const AsyncValue.loading();
    try {
      final user_ = await _repository.updateProfile(user);
      state = AsyncValue.data(user_);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
