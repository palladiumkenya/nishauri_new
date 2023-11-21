import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';

class AuthController extends StateNotifier<AuthState> {
  /// Act as the view model that hold the state of component or screen
  final AuthRepository _repository;

  AuthController(this._repository) : super(AuthState()) {
    _repository.getAuthToken().then((value) => state = state.copyWith(token: value));
  }

  Future<void> login(String username, String password) async {
    try {
      final authState = await _repository.authenticate(username, password);
      await _repository.saveToken(authState.token);
      state = authState;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String username, String phoneNumber, String email,
      String password, String confirmPassword) async {
    await Future.delayed(const Duration(seconds: 5));
    try {
      final authState = await _repository.register(
          username, phoneNumber, password, confirmPassword, email);
      await _repository.saveToken(authState.token);
      state = authState;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verify(String otp) async {
    try {
      final isVerified = await _repository.verifyAccount(otp);
      state = state.copyWith(isAccountVerified: isVerified);
    } catch (e) {
      rethrow;
    }
  }

    Future<void> updateProfile(bool updateProfile) async {
    try {
      state = state.copyWith(isProfileComplete: updateProfile);
    } catch (e) {
      rethrow;
    }
  }



  Future<void> logout() async {
    _repository.deleteToken();
    state = state.copyWith(token: "");
  }

}
