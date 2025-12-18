import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final DioExceptionType? type;

  NetworkException({required this.message, this.statusCode, this.type});

  factory NetworkException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException(
          message:
              'Connection timeout. Cannot reach server at ${dioError.requestOptions.baseUrl}. Please check:\n'
              '1. Server is running and accessible\n'
              '2. Correct IP address and port\n'
              '3. Firewall settings\n'
              '4. Device and server are on the same network',
          type: dioError.type,
        );
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Request timeout. Server took too long to respond.',
          type: dioError.type,
        );

      case DioExceptionType.badResponse:
        return NetworkException(
          message: _handleStatusCode(dioError.response?.statusCode),
          statusCode: dioError.response?.statusCode,
          type: dioError.type,
        );

      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request was cancelled',
          type: dioError.type,
        );

      case DioExceptionType.connectionError:
        final errorMessage = dioError.message ?? 'Connection error';
        return NetworkException(
          message:
              errorMessage.contains('Failed host lookup') ||
                  errorMessage.contains('Connection refused') ||
                  errorMessage.contains('Network is unreachable')
              ? 'Cannot connect to server. Please check if the server is running at ${dioError.requestOptions.baseUrl}${dioError.requestOptions.path}'
              : 'No internet connection. Please check your network.',
          type: dioError.type,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Bad certificate',
          type: dioError.type,
        );

      case DioExceptionType.unknown:
        final errorMessage = dioError.message ?? 'An unexpected error occurred';
        return NetworkException(
          message:
              errorMessage.contains('SocketException') ||
                  errorMessage.contains('Failed host lookup')
              ? 'Cannot connect to server. Please check if the server is running and accessible.'
              : errorMessage,
          type: dioError.type,
        );
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. You don\'t have permission to access this resource.';
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 502:
        return 'Bad gateway.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'Something went wrong. Status code: $statusCode';
    }
  }

  @override
  String toString() => message;
}
