import '../request_context.dart';
import '../request_handler.dart';
import '../../../storage/secure_storage_service.dart';

/// Handler that injects authentication token into the request context.
/// 
/// Single Responsibility: Token Management
/// - Retrieves token from SecureStorage if not already in context
/// - Adds token to context for use by subsequent handlers
class TokenInjectionHandler extends RequestHandler {
  @override
  Future<RequestContext> doHandle(RequestContext context) async {
    // If token is already in context, no need to retrieve it
    if (context.token != null && context.token!.isNotEmpty) {
      return context;
    }

    // If auth is not required, skip token injection
    if (!context.requiresAuth) {
      return context;
    }

    // Retrieve token from SecureStorage
    try {
      final token = await SecureStorage.getToken();
      if (token.isNotEmpty) {
        return context.copyWith(token: token);
      }
    } catch (e) {
      // If token retrieval fails, we continue without token
      // The request will fail at the API level, which is expected behavior
      print('TokenInjectionHandler: Failed to retrieve token - $e');
    }

    return context;
  }
}

