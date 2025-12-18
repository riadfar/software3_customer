import '../../../../core/storage/secure_storage_service.dart';
import '../api/auth_api.dart';
import '../model/customer.dart';

class AuthRepo {
  final AuthApi authApi;

  AuthRepo({required this.authApi});

  Future<void> login({
    required String accountNumber,
    required String password,
  }) async {
    try {
      print("start repo");
      final response = await authApi.login(
        data: {"username": accountNumber, "password": password},
      );
      final Map<String, dynamic> data = response['data'];
      final String token = data['token'];

      SecureStorage.storeToken(token);
    } catch (e) {
      rethrow;
    }
  }

  Future<Customer> getCustomerAccount({required String accountNumber}) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await authApi.getCustomerAccount(
        accountNumber: accountNumber,
        token: token,
      );
      print(response);
      final data = response['data'] as Map<String, dynamic>;
      final Customer customer = Customer.fromMap(data['customer']);
      return customer;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      await authApi.changePassword(
        token: token,
        data: {"old_password": oldPassword, "new_password": newPassword},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      await authApi.logout(token: token);
    } catch (e) {
      rethrow;
    }
  }
}
