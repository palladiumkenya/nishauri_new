import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:http/http.dart' as http;

class AuthController extends StateNotifier<AsyncValue<String>> {
  /// Act as the view model that hold the state of component or screen
  final AuthRepository _repository =
      AuthRepository(http.Client()); //Can inject this dependency tp decouple

  AuthController(super.state);

  Future<void> login(String username, String password) async {
    // await Future.delayed(Duration(seconds: 5));
    state = const AsyncValue.loading();
    try {
      final token = await _authenticate(username, password);
      await LocalStorage.saveToken(token);
      state = AsyncValue.data(token);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> register(String username, String phoneNumber,String email, String password,
      String confirmPassword) async {
    state = const AsyncValue.loading();
    try {
      final token =
          await _register(username, phoneNumber,email, password, confirmPassword);
      await LocalStorage.saveToken(token);
      state = AsyncValue.data(token);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
  Future<void> verify(String otp) async {
    state = const AsyncValue.loading();
    try {
      final token =
          await _verifyUser(otp);
      await LocalStorage.saveToken(token);
      state = AsyncValue.data(token);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> logout() async {
    await LocalStorage.deleteToken();
    state = const AsyncValue.data('');
  }

  Future<String> _authenticate(String username, String password) async {
    // final response = await _repository.authenticate(username, password);
    return "tokn";
  }

  Future<String> _verifyUser(String otp) async {
    // final response = await _repository.authenticate(username, password);
    return "12345";
  }

  Future<String> _register(String username, String phoneNumber,String email, String password,
      String confirmPassword) async {
    // TODO: Implement registration logic here.
    return "token";
  }
}
