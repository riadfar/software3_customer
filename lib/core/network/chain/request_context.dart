import 'package:dio/dio.dart';

/// Request context that carries data through the Chain of Responsibility.
/// 
/// This class acts as a Data Transfer Object (DTO) that holds all request
/// information as it passes through the handler chain. Handlers can read
/// and modify the context as needed.
class RequestContext {
  final String url;
  final String method;
  final dynamic body;
  Map<String, String>? headers;
  String? token;
  final bool requiresAuth;
  Response? response;
  Exception? error;

  RequestContext({
    required this.url,
    required this.method,
    this.body,
    this.headers,
    this.token,
    this.requiresAuth = true,
    this.response,
    this.error,
  });

  /// Creates a copy of the context with updated values.
  /// Useful for creating modified versions while maintaining immutability.
  RequestContext copyWith({
    String? url,
    String? method,
    dynamic body,
    Map<String, String>? headers,
    String? token,
    bool? requiresAuth,
    Response? response,
    Exception? error,
  }) {
    return RequestContext(
      url: url ?? this.url,
      method: method ?? this.method,
      body: body ?? this.body,
      headers: headers ?? this.headers,
      token: token ?? this.token,
      requiresAuth: requiresAuth ?? this.requiresAuth,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }

  /// Checks if the context has an error.
  bool get hasError => error != null;

  /// Checks if the context has a response.
  bool get hasResponse => response != null;

  /// Gets the response data as Map<String, dynamic>.
  /// Returns null if no response or if response data is not a Map.
  Map<String, dynamic>? get responseData {
    if (response?.data is Map<String, dynamic>) {
      return response!.data as Map<String, dynamic>;
    }
    return null;
  }
}

