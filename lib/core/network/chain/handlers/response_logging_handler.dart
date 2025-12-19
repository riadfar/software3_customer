import '../request_context.dart';
import '../request_handler.dart';

/// Handler that logs request and response details for debugging.
/// 
/// Single Responsibility: Response Logging
/// - Logs request details (optional, can be disabled)
/// - Logs response data (optional, can be disabled)
/// - Provides debug information
/// 
/// Note: This handler can be enabled/disabled without affecting
/// the request flow or API contract.
class ResponseLoggingHandler extends RequestHandler {
  final bool enabled;

  ResponseLoggingHandler({this.enabled = true});

  @override
  Future<RequestContext> doHandle(RequestContext context) async {
    if (!enabled) {
      return context;
    }

    // Log request details
    print('=== Request Log ===');
    print('Method: ${context.method}');
    print('URL: ${context.url}');
    print('Headers: ${context.headers}');
    if (context.body != null) {
      print('Body: ${context.body}');
    }

    // Log response details if available
    if (context.hasResponse) {
      print('=== Response Log ===');
      print('Status Code: ${context.response?.statusCode}');
      print('Response Data: ${context.response?.data}');
    }

    // Log error if present
    if (context.hasError) {
      print('=== Error Log ===');
      print('Error: ${context.error}');
    }

    print('==================');

    return context;
  }
}

