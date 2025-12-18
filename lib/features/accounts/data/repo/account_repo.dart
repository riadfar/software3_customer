import '../../../../core/storage/secure_storage_service.dart';
import '../api/account_api.dart';
import '../model/account.dart';
import '../model/sub_account.dart';

class AccountRepo {
  final AccountApi accountApi;

  AccountRepo({required this.accountApi});

  Future<Account> getCustomerAccount({required String accountNumber}) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await accountApi.getCustomerAccount(
        accountNumber: accountNumber,
        token: token,
      );
      print(response);
      final data = response['data'] as Map<String, dynamic>;
      final Account account = Account.fromMap(data);
      return account;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editCustomerInfo({
    required String accountNumber,
    String? fullName,
    String? phone,
    String? address,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await accountApi.editCustomerInfo(
        accountNumber: accountNumber,
        token: token,
        body: {
          if (fullName != null) "full_name": fullName,
          if (phone != null) "phone": phone,
          if (address != null) "address": address,
        },
      );
      print(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> freezeRequest({
    required String accountNumber,
    required String reason,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await accountApi.freezeRequest(
        token: token,
        body: {"accountNumber": accountNumber, "reason": reason},
      );
      print(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> closureRequest({
    required String accountNumber,
    required String reason,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await accountApi.closureRequest(
        token: token,
        body: {"accountNumber": accountNumber, "reason": reason},
      );
      print(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<SubAccount> createSubAccount({
    required String mainAccountNumber,
    required String subAccountName,
  }) async {
    try {
      print("start repo: createSubAccount");
      final String token = await SecureStorage.getToken();

      final response = await accountApi.createSubAccount(
        token: token,
        body: {"account_number": mainAccountNumber, "name": subAccountName},
      );

      print(response);
      final data = response['data'];

      return SubAccount(
        id: data['id'],
        name: data['sub_account_name'],
        balance: data['balance'],
      );
    } catch (e) {
      rethrow;
    }
  }
}
