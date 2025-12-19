import 'dart:io';

class ApiEndpoints {

  static String get baseUrl {

    return 'http://192.168.1.110:8000';

  }

  // Auth endpoints
  static const String login = '/api/login';
  static const String logout = '/api/logout';
  static const String changePassword = '/api/change-password';


  // Account endpoints
  static const String customerAccount = '/api/customer/customer-account';
  static String customerAccountEndpoint(String accountNumber) {
    return '${ApiEndpoints.customerAccount}?search=$accountNumber';
  }
  static const String createSubAccount = '/api/customer/sub-account';
  static String editCustomerAccount(String accountNumber) => '/api/customer/edit-customer/$accountNumber';
  static const String getSubAccounts = '/api/customer/sub-account/1';


  // Transaction endpoints
  static const String transferRequest = '/api/customer/transfer-request';
  static const String deposit = '/api/customer/deposit';
  static const String getTransactionHistory = '/api/customer/transaction-history';
  static const String recurringTransfer = '/api/customer/recurring-transfer';
  static const String getRecurringTransfers = '/api/customer/recurring-transfers';
  static String cancelRecurringTransfers(int id) => '/api/customer/recurring-transfer/$id/cancel';


  // Freeze - Closure endpoints
  static const String requestClosure = "/api/customer/request-closure";
  static const String freezeRequest = "/api/customer/freeze-request";




}
String token = "";
