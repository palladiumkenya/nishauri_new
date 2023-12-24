import 'package:nishauri/src/shared/models/token_pair.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveToken(TokenPair token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token.accessToken);
    await prefs.setString('refresh_token', token.refreshToken);
  }

  static Future<TokenPair> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return TokenPair(
        accessToken: prefs.getString('access_token') ?? '',
        refreshToken: prefs.getString('refresh_token') ?? '');
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  static Future<String> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
