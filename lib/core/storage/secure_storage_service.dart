import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/api_endpoints.dart';
import '../utils/constants.dart';
const secureStorage = FlutterSecureStorage();

class SecureStorage {
  static Future<void> removeAll() async {
    await secureStorage.delete(key: 'token');
    token = '';
    await secureStorage.delete(key: 'refreshToken');
    await secureStorage.delete(key: 'email');
  }

  static Future<void> storeToken(String token) async =>
      await secureStorage.write(key: 'token', value: token);

  static Future<String> getToken() async =>
      await secureStorage.read(key: 'token') ?? '';

  static Future<void> removeToken() async =>
      await secureStorage.delete(key: 'token');

  static Future<void> storeRefreshToken(String token) async =>
      await secureStorage.write(key: 'refreshToken', value: token);

  static Future<String> getRefreshToken() async =>
      await secureStorage.read(key: 'refreshToken') ?? '';

  static Future<void> removeRefreshToken() async =>
      await secureStorage.delete(key: 'refreshToken');

  static Future<void> storeEmail(String email) async =>
      await secureStorage.write(key: 'email', value: email);

  static Future<String> getEmail() async =>
      await secureStorage.read(key: 'email') ?? '';

  static Future<void> removeEmail() async =>
      await secureStorage.delete(key: 'email');

  static Future<void> storeAccountNumber(String accountNumber) async =>
      await secureStorage.write(key: 'accountNumber', value: accountNumber);

  static Future<String?> getAccountNumber() async =>
      await secureStorage.read(key: 'accountNumber');

  static Future<void> removeAccountNumber() async =>
      await secureStorage.delete(key: 'accountNumber');
}

