class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException(super.message, [super.statusCode]);
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class AuthenticationException extends AppException {
  const AuthenticationException(super.message);
}

class AuthorizationException extends AppException {
  const AuthorizationException(super.message);
}

class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

