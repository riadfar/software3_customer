import '../request_context.dart';
import '../request_handler.dart';
import '../../headers.dart';

/// Handler that constructs the final headers for the request.
/// 
/// Single Responsibility: Header Construction
/// - Merges auth headers with content-type headers
/// - Ensures all required headers are present
/// - Prepares headers for RemoteApi
class HeaderConstructionHandler extends RequestHandler {
  @override
  Future<RequestContext> doHandle(RequestContext context) async {
    // If headers are already provided and complete, use them as-is
    if (context.headers != null && 
        context.headers!.containsKey('Authorization') &&
        context.headers!.containsKey('Content-Type')) {
      return context;
    }

    Map<String, String> finalHeaders;

    // If auth is required and we have a token, build auth headers
    if (context.requiresAuth && context.token != null && context.token!.isNotEmpty) {
      finalHeaders = headersWithAuthContent(context.token!);
    } else if (context.requiresAuth) {
      // Auth required but no token - this is an error condition
      // But we'll let the request proceed and fail at API level
      // to maintain backward compatibility
      finalHeaders = headersWithContent;
    } else {
      // No auth required, use content headers only
      finalHeaders = headersWithContent;
    }

    // Merge with any existing headers (existing headers take precedence)
    if (context.headers != null) {
      finalHeaders = {
        ...finalHeaders,
        ...context.headers!,
      };
    }

    return context.copyWith(headers: finalHeaders);
  }
}

