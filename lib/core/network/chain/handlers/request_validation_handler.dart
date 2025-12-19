import '../request_context.dart';
import '../request_handler.dart';

/// Handler that validates the request structure before sending.
/// 
/// Single Responsibility: Request Validation
/// - Validates URL format
/// - Checks required fields are present
/// - Ensures request structure is correct
/// 
/// Note: This is internal validation only. It does not modify
/// the API contract or request structure sent to the backend.
class RequestValidationHandler extends RequestHandler {
  @override
  Future<RequestContext> doHandle(RequestContext context) async {
    // Validate URL
    if (context.url.isEmpty) {
      return context.copyWith(
        error: Exception('Request URL cannot be empty'),
      );
    }

    // Validate URL format (basic check)
    if (!context.url.startsWith('/')) {
      // URLs should be relative paths starting with /
      // This is an internal validation, not affecting the API contract
      print('RequestValidationHandler: Warning - URL does not start with /');
    }

    // Validate method
    final validMethods = ['GET', 'POST', 'PUT', 'DELETE'];
    if (!validMethods.contains(context.method.toUpperCase())) {
      return context.copyWith(
        error: Exception('Invalid HTTP method: ${context.method}'),
      );
    }

    // For POST/PUT requests, body can be null (some endpoints don't require body)
    // This is acceptable, so we don't validate body presence

    // All validations passed
    return context;
  }

  @override
  bool shouldStopOnError() => true; // Stop chain on validation errors
}

