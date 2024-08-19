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

  Future<void> updateProfile(Map<String, dynamic> user) async {
    final user_ = await _service.updateProfile(user);
    return; //user_;
  }

  Future<String> verifyAccount(Map<String, dynamic> data) async {
    return await _service.accountVerify(data);
  }

  Future<String> getOTPCode(String mode)async {
    return await _service.requestVerificationCode(mode);
  }

  Future<String> revokeToken() async {
    final response = await _service.revokeToken();
    return response;
  }

  Future<void> saveGenderAge() async {
    await _service.saveGenderAge();
  }

}
