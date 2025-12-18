import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/headers.dart';

class TransactionApi {
  Future<Map<String, dynamic>> transferRequest({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.transferRequest}");
      final response = await RemoteApi.post(
        ApiEndpoints.transferRequest,
        body: body,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deposit({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.deposit}");
      final response = await RemoteApi.post(
        ApiEndpoints.deposit,
        body: body,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> recurringTransfer({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.recurringTransfer}");
      final response = await RemoteApi.post(
        ApiEndpoints.recurringTransfer,
        body: body,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  Future<Map<String, dynamic>> cancelRecurringTransfers({
    required int id,
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.cancelRecurringTransfers(id)}");
      final response = await RemoteApi.post(
        ApiEndpoints.cancelRecurringTransfers(id),
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  Future<Map<String, dynamic>> getTransactionHistory({
    required String token,
  }) async {
    try {
      print(
        "Calling API: ${ApiEndpoints.getTransactionHistory}",
      );
      final response = await RemoteApi.get(
        ApiEndpoints.getTransactionHistory,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRecurringTransfers({
    required String token,
  }) async {
    try {
      print(
        "Calling API: ${ApiEndpoints.getRecurringTransfers}",
      );
      final response = await RemoteApi.get(
        ApiEndpoints.getRecurringTransfers,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDestinationName({
    required String accountNumber,
    required String token,
  }) async {
    try {
      print(
        "Calling API: ${ApiEndpoints.customerAccountEndpoint(accountNumber)}",
      );
      final response = await RemoteApi.get(
        ApiEndpoints.customerAccountEndpoint(accountNumber),
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
