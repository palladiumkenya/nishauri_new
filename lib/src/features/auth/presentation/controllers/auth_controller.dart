import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/user/data/respositories/UserRepository.dart';
import 'package:nishauri/src/shared/models/token_pair.dart';
import 'dart:developer' as developer;

class AuthController extends StateNotifier<AsyncValue<AuthState>> {
  /// Act as the view model that hold the state of component or screen
  final AuthRepository _repository;
  final UserRepository _userRepository;

  AuthController(this._repository, this._userRepository) : super(const AsyncValue.loading()) {
    loadAuthState();
  }

  Future<void> loadAuthState() async {
    try {
      final verified = await _repository.getIsVerified();
      final user = await _userRepository.getUser();
      state = AsyncValue.data(AuthState(
        isAccountVerified: verified,
        isProfileComplete: true,
        // isAccountVerified: true,
        // isProfileComplete: true,
        isAuthenticated: true,
      ));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> login(Map<String, dynamic> credentials) async {
    try {
      final authResponse = await _repository.authenticate(credentials);
      var msg = authResponse.accessToken ?? '';
      if (msg.isEmpty){
        throw authResponse.message??'';
      }
      await _repository.saveToken(TokenPair(
        accessToken: authResponse.accessToken ?? '',
        refreshToken: authResponse.refreshToken ?? '',
      ));
      await _repository.saveUserId(authResponse.userId??'');
      await _repository.saveIsVerified(authResponse.accountVerified);
      state = AsyncValue.data(
        AuthState(
          isAccountVerified: authResponse.accountVerified,
          isProfileComplete: authResponse.profileUpdated,
          isAuthenticated: msg.isNotEmpty,

        ),
      );
    } catch (e) {
      developer.log('-->login ${e.toString()}');
      rethrow;
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    try {
      final authResponse = await _repository.register(data);
      var isAuth = authResponse.accessToken ?? '';
      if (isAuth.isEmpty){
        throw authResponse.message??'';
      }
      await _repository.saveToken(TokenPair(
        accessToken: authResponse.accessToken ?? '',
        refreshToken: authResponse.refreshToken?? '',
      ));
      await _repository.saveUserId(authResponse.userId??'');
      await _repository.saveIsVerified(authResponse.accountVerified);
      state = AsyncValue.data(AuthState(
        isAccountVerified: authResponse.accountVerified,
        isProfileComplete: authResponse.profileUpdated,
        isAuthenticated: isAuth.isNotEmpty,
      ));
    } catch (e) {
      developer.log('-->register ${e.toString()}');
      rethrow;
    }
  }

  Future<void> markProfileAsUpdated() async {
    try {
      state.when(
        data: (value) => state = AsyncValue.data(
          value.copyWith(
            isProfileComplete: true,
          ),
        ),
        error: (error, stackTrace) => state = AsyncValue.error(error, stackTrace),
        loading: () => state = const AsyncValue.loading(),
      );
    } catch (e)
    {
      rethrow;
    }

  }

  Future<void> markProfileAsAccountVerified() async {
    state.when(
      data: (value) => state = AsyncValue.data(
        value.copyWith(
          isAccountVerified: true,
        ),
      ),
      error: (error, stackTrace) => state = AsyncValue.error(error, stackTrace),
      loading: () => state = const AsyncValue.loading(),
    );
  }

  Future<void> logout() async {
    _repository.deleteToken();
    _repository.deleteUserId();
    state.when(
      data: (value) => state = AsyncValue.data(
        value.copyWith(
          isAuthenticated: false,
        ),
      ),
      error: (error, stackTrace) => state = AsyncValue.error(error, stackTrace),
      loading: () => state = const AsyncValue.loading(),
    );
  }
}
