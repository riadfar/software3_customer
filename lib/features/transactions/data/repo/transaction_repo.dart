import 'dart:math';

import '../../../../core/storage/secure_storage_service.dart';
import '../api/transaction_api.dart';
import '../models/recurring_transfer.dart';
import '../models/transaction.dart';

class TransactionRepo {
  final TransactionApi transactionApi;

  TransactionRepo({required this.transactionApi});

  Future<void> transferRequest({
    required String fromAccountNumber,
    required String toAccountNumber,
    required double amount,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await transactionApi.transferRequest(
        token: token,
        body: {
          "from_account_number": fromAccountNumber,
          "to_account_number": toAccountNumber,
          "amount": amount,
          "description": "Normal Transaction",
        },
      );
      print(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deposit({
    required String accountNumber,
    required String reference,
    required double amount,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await transactionApi.deposit(
        token: token,
        body: {
          "account_number": accountNumber,
          "amount": amount,
          "reference": reference,
          "description": "Normal Transaction",
        },
      );
      print(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> recurringTransfer({
    required String title,
    required String fromAccountNumber,
    required String toAccountNumber,
    required double amount,
    required Frequency frequency,
    required String startDate,
    required String endDate,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await transactionApi.recurringTransfer(
        token: token,
        body: {
          "title": title,
          "from_account_number": fromAccountNumber,
          "to_account_number": toAccountNumber,
          "amount": amount,
          "frequency": frequency.name,
          "start_date": startDate,
          "end_date": endDate,
        },
      );
      print(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelRecurringTransfers({required int id}) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await transactionApi.cancelRecurringTransfers(
        id: id,
        token: token,
      );
      print(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RecurringTransfer>> getRecurringTransfers() async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await transactionApi.getRecurringTransfers(token: token);
      print(response);
      final List<dynamic> dataList = response['data'];

      final List<RecurringTransfer> transfers = dataList
          .map((jsonItem) => RecurringTransfer.fromMap(jsonItem))
          .toList();

      return transfers;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Transaction>> getTransactionHistory() async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await transactionApi.getTransactionHistory(token: token);
      print(response);
      final Map<String, dynamic> data = response['data'];

      final List<dynamic> transactionsList = data['transactions'];

      final List<Transaction> history = transactionsList
          .map((jsonItem) => Transaction.fromMap(jsonItem))
          .toList();

      return history;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getDestinationName({required String accountNumber}) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await transactionApi.getDestinationName(
        accountNumber: accountNumber,
        token: token,
      );
      print(response);
      final data = response['data'] as Map<String, dynamic>;
      final customer = data['customer'] as Map<String, dynamic>;
      final fullName = customer['full_name'] as String;
      return fullName;
    } catch (e) {
      rethrow;
    }
  }
}
