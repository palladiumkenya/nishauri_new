import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';

class AuthController extends StateNotifier<AuthState> {
  /// Act as the view model that hold the state of component or screen
  final AuthRepository _repository;

  AuthController(this._repository) : super(AuthState.defaultState()) {
    loadAuthState();
  }

  Future<void> loadAuthState() async {
    String token = await _repository.getAuthToken();
    String user = await _repository.getUserId();
    state = state.copyWith(token: token, user: user);
  }

  Future<void> login(Map<String, dynamic> credentials) async {
    try {
      final authState = await _repository.authenticate(credentials);
      await _repository.saveToken(authState.token);
      await _repository.saveUserId(authState.user);
      state = authState;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    try {
      final authState = await _repository.register(data);
      await _repository.saveToken(authState.token);
      state = authState;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verify(Map<String, dynamic> data) async {
    try {
      final isVerified = await _repository.verifyAccount(data);
      state = state.copyWith(isAccountVerified: isVerified);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markProfileAsUpdated() async {
    try {
      state = state.copyWith(isProfileComplete: true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    _repository.deleteToken();
    _repository.deleteUserId();
    state = state.copyWith(token: "", user: "");
  }
}
