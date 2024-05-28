
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/models/reset_password.dart';
import 'package:nishauri/src/features/auth/data/respositories/reseet_password_repository.dart';
import 'dart:developer' as developer;

class ResetPasswordController extends StateNotifier<AsyncValue<PasswordReset>>{
  final ResetPasswordRepository _repository;

  ResetPasswordController(this._repository) : super (const AsyncValue.loading());

  Future<String> resetPassword(Map<String, dynamic> data) async{
    try {
      return await _repository.resetPassword(data);
    } catch (e) {
      developer.log('-->resetPassword ${e.toString()}');
      rethrow;
    }
  }
  Future<String> verifyResetPassword(Map<String, dynamic> data) async{
    try {
      return await _repository.verifyResetPassword(data);
    } catch (e) {
      developer.log('-->resetPassword ${e.toString()}');
      rethrow;
    }
  }

  Future<String> changePassword(Map<String, dynamic> data) async{
    try {
      return await _repository.changePassword(data);
    } catch (e) {
      developer.log('-->changePassword ${e.toString()}');
      rethrow;
    }
  }

  Future<String> updatePassword(Map<String, dynamic> data) async{
    try {
      return await _repository.updatePassword(data);
    } catch (e) {
      developer.log('-->changePassword ${e.toString()}');
      rethrow;
    }
  }
}