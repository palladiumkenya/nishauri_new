import 'package:nishauri/src/features/auth/data/services/ResetPassword.dart';

class ResetPasswordRepository {
  final ResetPasswordService _service;

  ResetPasswordRepository(this._service);

  Future<String> verifyResetPassword(Map<String, dynamic> data) async {
    return await _service.verifyResetPassword(data);
  }

  Future<String> resetPassword(Map<String, dynamic> data) async {
    return await _service.resetPassword(data);
  }

  Future<String> changePassword(Map<String, dynamic> data) async {
    return await _service.changePassword(data);
  }
}