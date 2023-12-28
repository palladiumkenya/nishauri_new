import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/respositories/UserRepository.dart';
import 'package:nishauri/src/features/user/data/services/UserService.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/models/token_pair.dart';

class AuthController extends StateNotifier<AuthState> {
  /// Act as the view model that hold the state of component or screen
  final AuthRepository _repository;
  late TokenPair _tokenPair;

  AuthController(this._repository) : super(AuthState.defaultState()) {
    loadAuthState();
  }

  TokenPair get token {
    return _tokenPair;
  }

  Future<void> loadAuthState() async {
    _tokenPair = await _repository.getAuthToken(); //reads share preference
    final userRepo = UserRepository(UserService(_tokenPair));
    try {
      final _user = await userRepo.getUser();
      state = state.copyWith(
          isAccountVerified: _user.accountVerified,
          isProfileComplete: _user.profileUpdated,
          isAuthenticated: true);
    } catch (e) {
      // TODO Better handle this exception
      rethrow;
    }
  }

  Future<void> login(Map<String, dynamic> credentials) async {
    try {
      final authResponse = await _repository.authenticate(credentials);
      await _repository.saveToken(TokenPair(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      ));
      state = AuthState(
        isAccountVerified: authResponse.accountVerified,
        isProfileComplete: authResponse.profileUpdated,
        isAuthenticated: authResponse.accessToken.isNotEmpty,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    try {
      final authResponse = await _repository.register(data);
      await _repository.saveToken(TokenPair(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      ));
      state = AuthState(
        isAccountVerified: authResponse.accountVerified,
        isProfileComplete: authResponse.profileUpdated,
        isAuthenticated: authResponse.accessToken.isNotEmpty,
      );
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

  Future<void> markProfileAsAccountVerified() async {
    try {
      state = state.copyWith(isAccountVerified: true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    _repository.deleteToken();
    state = state.copyWith(isAuthenticated: false);
  }
}
