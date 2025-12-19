import 'dart:convert';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/headers.dart';
import '../../../../core/network/network_facade.dart';

/// API class for authentication-related endpoints.
/// 
/// This class has been refactored to use NetworkFacade, which automatically
/// handles token retrieval and header construction. The public interface and
/// response structure remain unchanged to ensure zero breaking changes.
class AuthApi {
  /// Authenticates a user with account number and password.
  /// 
  /// This endpoint does not require authentication (login endpoint),
  /// so we explicitly set requiresAuth to false and pass headersWithContent
  /// to maintain the exact same request structure.
  Future<Map<String, dynamic>> login({
    required Map<String, String> data,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.login}");
      // Login doesn't require auth, so we pass headers explicitly
      // NetworkFacade will use them as-is, maintaining backward compatibility
      final response = await NetworkFacade.post(
        ApiEndpoints.login,
        body: json.encode(data),
        headers: headersWithContent, // Same headers as original implementation
        requiresAuth: false,
      );
      print("API Response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves customer account information.
  /// 
  /// Token parameter is kept for backward compatibility but is no longer used
  /// as NetworkFacade automatically retrieves the token from SecureStorage.
  Future<Map<String, dynamic>> getCustomerAccount({
    required String accountNumber,
    required String token, // Kept for backward compatibility, not used internally
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.customerAccountEndpoint(accountNumber)}");
      // NetworkFacade automatically adds auth headers
      final response = await NetworkFacade.get(
        ApiEndpoints.customerAccountEndpoint(accountNumber),
        requiresAuth: true, // Default, but explicit for clarity
      );
      print("API Response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Changes the user's password.
  /// 
  /// Token parameter is kept for backward compatibility but is no longer used
  /// as NetworkFacade automatically retrieves the token from SecureStorage.
  Future<Map<String, dynamic>> changePassword({
    required Map<String, String> data,
    required String token, // Kept for backward compatibility, not used internally
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.changePassword}");
      // NetworkFacade automatically adds auth headers
      final response = await NetworkFacade.post(
        ApiEndpoints.changePassword,
        body: json.encode(data),
        requiresAuth: true, // Default, but explicit for clarity
      );
      print("API Response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Logs out the current user.
  /// 
  /// Token parameter is kept for backward compatibility but is no longer used
  /// as NetworkFacade automatically retrieves the token from SecureStorage.
  Future<Map<String, dynamic>> logout({
    required String token, // Kept for backward compatibility, not used internally
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.logout}");
      // NetworkFacade automatically adds auth headers
      final response = await NetworkFacade.post(
        ApiEndpoints.logout,
        requiresAuth: true, // Default, but explicit for clarity
      );
      print("API Response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
