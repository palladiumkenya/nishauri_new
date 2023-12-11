import 'dart:io';

import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/services/UserService.dart';

class UserRepository {
  final UserService _service;

  UserRepository(this._service);

  Future<User> getUser() async {
    final user = await _service.getUser();
    return user;
  }

  Future<User> updateProfile(User user) async {
    final user_ = await _service.updateProfile(user);
    return user_;
  }
}
