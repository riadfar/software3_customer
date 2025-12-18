import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/headers.dart';

class AccountApi {
  Future<Map<String, dynamic>> getCustomerAccount({
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

  Future<Map<String, dynamic>> editCustomerInfo({
    required String token,
    required String accountNumber,
    required Map<String, dynamic> body,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.editCustomerAccount(accountNumber)}");
      final response = await RemoteApi.put(
        ApiEndpoints.editCustomerAccount(accountNumber),
        body: body,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> freezeRequest({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.freezeRequest}");
      final response = await RemoteApi.post(
        ApiEndpoints.freezeRequest,
        body: body,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> closureRequest({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.requestClosure}");
      final response = await RemoteApi.post(
        ApiEndpoints.requestClosure,
        body: body,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createSubAccount({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.createSubAccount}");
      final response = await RemoteApi.post(
        ApiEndpoints.createSubAccount,
        body: body,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

}
