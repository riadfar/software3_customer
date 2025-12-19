import 'package:dio/dio.dart';
import '../request_context.dart';
import '../request_handler.dart';
import '../../network_exceptions.dart';

/// Handler that transforms errors into a consistent format.
/// 
/// Single Responsibility: Error Transformation
/// - Transforms DioException to NetworkException
/// - Wraps errors in consistent format
/// - Handles error context preservation
/// 
/// Note: Error transformation happens internally. The same exception
/// types are still thrown to maintain backward compatibility.
class ErrorTransformationHandler extends RequestHandler {
  @override
  Future<RequestContext> doHandle(RequestContext context) async {
    // If there's no error, pass through unchanged
    if (!context.hasError || context.error == null) {
      return context;
    }

    // Transform DioException to NetworkException
    if (context.error is DioException) {
      final dioException = context.error as DioException;
      final networkException = NetworkException.fromDioError(dioException);
      
      return context.copyWith(error: networkException);
    }

    // For other exceptions, wrap them in NetworkException for consistency
    if (context.error is! NetworkException) {
      final originalError = context.error!;
      final networkException = NetworkException(
        message: originalError.toString(),
        statusCode: null,
      );
      
      return context.copyWith(error: networkException);
    }

    // Already a NetworkException, return as-is
    return context;
  }
}

