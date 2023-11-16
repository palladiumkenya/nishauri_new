import 'dart:io';

import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/services/UserService.dart';

class UserRepository {
  final UserService _service;
  final String _userToken;

  UserRepository(this._service, this._userToken);

  Future<User> getUser() async {
    final user = await _service.getUser(_userToken);
    return user;
  }


}
