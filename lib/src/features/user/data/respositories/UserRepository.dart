import 'dart:io';

import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/services/UserService.dart';

class UserRepository {
  final UserService _userService;
  final String _userToken;

  UserRepository(this._userService, this._userToken);

  Future<User> getUser() async {
    final user = await _userService.getUser(_userToken);
    return user;
  }
}
