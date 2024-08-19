import 'dart:ffi';

import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/user/data/services/UserService.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/shared/models/token_pair.dart';

class AuthRepository {
  final AuthApiService _service;

  AuthRepository(this._service);


  Future<AuthResponse> authenticate(Map<String, dynamic> credentials) async {
    final response = await _service.authenticate(credentials);
    return response;
  }

  Future<AuthResponse> register(Map<String, dynamic> data) async {
    final response = await _service.register(data);
    return response;
  }

  Future<TokenPair?> getAuthToken() async {
    final token = await LocalStorage.getToken();
    return token;
  }

  Future<TokenPair> saveToken(TokenPair token) async {
    await LocalStorage.saveToken(token);
    return token;
  }

  Future<void> deleteToken() async {
    await LocalStorage.deleteToken();
  }

  Future<String> getUserId() async {
    return await LocalStorage.get("user");
  }



  Future<void> saveUserId(String userId) async {
    await LocalStorage.save("user", userId);
  }

  Future<void> savePhoneNumber(String phone) async {
    await LocalStorage.save("phone", phone);
  }

  Future<void> deletePhoneNumber() async {
    await LocalStorage.delete("phone");
  }

  Future<String> getUserPhoneNumber() async {
    var phone = await LocalStorage.get("phone");
    return phone;
  }

  Future<void> deleteUserId() async {
    await LocalStorage.delete("user");
  }

  Future<void> saveIsVerified(bool isVerified) async {
    await LocalStorage.saveIsVerifiedAccount("acc", isVerified);
  }

  Future<bool> getIsVerified() async {
    return await LocalStorage.getIsVerified("acc");
  }

  // For Nuru

  Future<void> saveAppointment(String appDate) async {
    await LocalStorage.save("appointment_datetime", appDate);
  }

  Future<String> getAppointmentDate() async {
    return await LocalStorage.get("appointment_datetime");
  }

  Future<void> saveGender(String gender) async {
    await LocalStorage.save("gender", gender);
  }

  Future<String> getGender() async {
    return await LocalStorage.get("gender");
  }

  Future<void> saveAge(String age) async {
    await LocalStorage.save("age", age);
  }

  Future<String> getAge() async {
    return await LocalStorage.get("age");
  }

  Future<void> saveRegimen(String regimen) async {
    await LocalStorage.save("regimen", regimen);
  }

  Future<String> getRegimen() async {
    return await LocalStorage.get("regimen");
  }

  Future<void> saveVL(String vl) async {
    await LocalStorage.save("viral_load", vl);
  }

  Future<String> getVL() async {
    return await LocalStorage.get("viral_load");
  }

  Future<void> saveVlDate(String vlDate) async {
    await LocalStorage.save("viral_load_date", vlDate);
  }

  Future<String> getVlDate() async {
    return await LocalStorage.get("viral_load_date");
  }

}
