import 'dart:convert';


import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/headers.dart';

class AuthApi {
  Future<Map<String, dynamic>> login({
    required Map<String, String> data,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.login}");
      final response = await RemoteApi.post(
        ApiEndpoints.login,
        body: json.encode(data),
        headers: headersWithContent,
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getCustomerAccount({
    required String accountNumber,
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.customerAccountEndpoint(accountNumber)}");
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

  Future<Map<String, dynamic>> changePassword({
    required Map<String, String> data,
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.changePassword}");
      final response = await RemoteApi.post(
        ApiEndpoints.changePassword,
        body: json.encode(data),
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> logout({
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.logout}");
      final response = await RemoteApi.post(
        ApiEndpoints.logout,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
