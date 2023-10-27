
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/api/AuthApiService.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tokenProvider = FutureProvider<String?>((ref) async {
  await Future.delayed(const Duration(seconds: 5));
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(Constants.TOKEN_KEY);
  return token;
});

final tokenStateProvider =
    StateNotifierProvider<TokenNotifier, AsyncValue<String?>>((ref) {
  final token = ref.watch(tokenProvider);
  return TokenNotifier(token);
});

class TokenNotifier extends StateNotifier<AsyncValue<String?>> {
  TokenNotifier(super.state);

  void setToken(String? token) {
    state = AsyncValue.data(token);
    if (token != null && token.isNotEmpty) {
      SharedPreferences.getInstance()
          .then((value) => value.setString(Constants.TOKEN_KEY, token));
    }
  }

  void clearToken() {
    state = const AsyncValue.data(null);
    SharedPreferences.getInstance()
        .then((value) => value.remove(Constants.TOKEN_KEY));
  }
}

final authServiceProvider = FutureProvider<AuthApiService>((ref) async {
  return AuthApiService();
});
