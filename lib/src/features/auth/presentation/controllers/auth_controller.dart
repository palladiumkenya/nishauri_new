import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';

class AuthController extends StateNotifier<AsyncValue<String>> {
  /// Act as the view model that hold the state of component or screen
  final AuthRepository _repository;

  AuthController(this._repository) : super(const AsyncValue.loading()) {
    _repository.getAuthToken().then((value) => state = AsyncValue.data(value));
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final token = await _repository.authenticate(username, password);
      await _repository.saveToken(token);
      state = AsyncValue.data(token);
    } catch (e) {
      state = AsyncValue.error(e,StackTrace.current);
    }
  }

  Future<void> register(String username, String phoneNumber, String email,
      String password, String confirmPassword) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 5));
    try {
      final token = await _repository.register(
          username, phoneNumber, password, confirmPassword, email);
      await _repository.saveToken(token);
      state = AsyncValue.data(token);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> verify(String otp) async {
    state = const AsyncValue.loading();
    try {
      final token = await _verifyUser(otp);
      await _repository.saveToken(token);
      state = AsyncValue.data(token);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> logout() async {
    _repository.deleteToken();
    state = const AsyncValue.data('');
  }

  Future<String> _verifyUser(String otp) async {
    // TODO Implement very using repository
    return "12345";
  }
}
