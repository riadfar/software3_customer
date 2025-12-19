import 'package:dio/dio.dart';
import 'dart:io';
import 'dio_client.dart';
import 'headers.dart';
import 'api_endpoints.dart';
import '../storage/secure_storage_service.dart';
import 'chain/request_chain.dart';
import 'chain/request_context.dart';

/// Facade pattern implementation for network operations.
/// 
/// This class provides a simplified interface for making API calls by:
/// - Automatically handling token retrieval from SecureStorage
/// - Constructing appropriate headers (with/without authentication)
/// - Initiating the Chain of Responsibility for request processing
/// - Wrapping the underlying RemoteApi while maintaining the same interface
/// 
/// The facade ensures zero breaking changes by maintaining identical
/// request/response structures while simplifying the API layer code.
class NetworkFacade {
  /// Singleton instance of RequestChain for processing requests.
  static final RequestChain _requestChain = RequestChain();
  /// Determines if a request requires authentication based on provided headers.
  /// 
  /// If headers are explicitly provided and contain 'Authorization', 
  /// the request is considered authenticated. Otherwise, if headers are null
  /// or don't contain auth, we check the requiresAuth parameter.
  static bool _requiresAuthentication(
    Map<String, String>? headers,
    bool requiresAuth,
  ) {
    if (headers != null && headers.containsKey('Authorization')) {
      return true;
    }
    return requiresAuth;
  }

  /// Constructs appropriate headers for the request.
  /// 
  /// If headers are provided, they are used as-is (for backward compatibility).
  /// If headers are null and auth is required, automatically constructs
  /// headers with authentication token from SecureStorage.
  static Future<Map<String, String>> _buildHeaders({
    Map<String, String>? headers,
    bool requiresAuth = true,
    bool includeContentType = true,
  }) async {
    // If headers are explicitly provided, use them (maintains backward compatibility)
    if (headers != null) {
      return headers;
    }

    // If auth is required, fetch token and build auth headers
    if (requiresAuth) {
      final token = await SecureStorage.getToken();
      if (includeContentType) {
        return headersWithAuthContent(token);
      } else {
        return headersWithAuth(token);
      }
    }

    // For non-authenticated requests, return content headers
    if (includeContentType) {
      return headersWithContent;
    }

    // Return empty headers if no content type needed
    return <String, String>{};
  }

  /// Makes a POST request.
  /// 
  /// [url] - The endpoint URL
  /// [body] - Request body (can be Map, String, FormData, etc.)
  /// [headers] - Optional headers. If provided, used as-is. If null and requiresAuth=true, 
  ///             auth headers are automatically added.
  /// [requiresAuth] - Whether this request requires authentication (default: true)
  /// 
  /// Returns the response data as Map<String, dynamic>
  /// 
  /// This method uses the Chain of Responsibility pattern for request processing:
  /// 1. Creates RequestContext with request details
  /// 2. Processes through handler chain (token injection, validation, headers)
  /// 3. Makes HTTP request via RemoteApi
  /// 4. Processes response through chain (error transformation, logging)
  /// 5. Returns response data (maintains backward compatibility)
  static Future<Map<String, dynamic>> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    try {
      // Create request context
      final context = RequestContext(
        url: url,
        method: 'POST',
        body: body,
        headers: headers,
        requiresAuth: requiresAuth,
      );

      // Process through chain
      final processedContext = await _requestChain.processRequest(context);

      // Handle errors (maintain backward compatibility)
      if (processedContext.hasError) {
        throw processedContext.error!;
      }

      // Extract and return response data
      if (processedContext.responseData != null) {
        return processedContext.responseData!;
      }

      // Fallback: if chain didn't provide response data, use old method
      // This ensures backward compatibility
      final requestHeaders = await _buildHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
        includeContentType: true,
      );

      final response = await RemoteApi.post(
        url,
        body: body,
        headers: requestHeaders,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Makes a GET request.
  /// 
  /// [url] - The endpoint URL
  /// [headers] - Optional headers. If provided, used as-is. If null and requiresAuth=true, 
  ///             auth headers are automatically added.
  /// [requiresAuth] - Whether this request requires authentication (default: true)
  /// 
  /// Returns the response data as Map<String, dynamic>
  /// 
  /// This method uses the Chain of Responsibility pattern for request processing.
  static Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    try {
      // Create request context
      final context = RequestContext(
        url: url,
        method: 'GET',
        headers: headers,
        requiresAuth: requiresAuth,
      );

      // Process through chain
      final processedContext = await _requestChain.processRequest(context);

      // Handle errors (maintain backward compatibility)
      if (processedContext.hasError) {
        throw processedContext.error!;
      }

      // Extract and return response data
      if (processedContext.responseData != null) {
        return processedContext.responseData!;
      }

      // Fallback: if chain didn't provide response data, use old method
      final requestHeaders = await _buildHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
        includeContentType: true,
      );

      final response = await RemoteApi.get(
        url,
        headers: requestHeaders,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Makes a PUT request.
  /// 
  /// [url] - The endpoint URL
  /// [body] - Request body (can be Map, String, FormData, etc.)
  /// [headers] - Optional headers. If provided, used as-is. If null and requiresAuth=true, 
  ///             auth headers are automatically added.
  /// [requiresAuth] - Whether this request requires authentication (default: true)
  /// 
  /// Returns the response data as Map<String, dynamic>
  /// 
  /// This method uses the Chain of Responsibility pattern for request processing.
  static Future<Map<String, dynamic>> put(
    String url, {
    dynamic body,
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    try {
      // Create request context
      final context = RequestContext(
        url: url,
        method: 'PUT',
        body: body,
        headers: headers,
        requiresAuth: requiresAuth,
      );

      // Process through chain
      final processedContext = await _requestChain.processRequest(context);

      // Handle errors (maintain backward compatibility)
      if (processedContext.hasError) {
        throw processedContext.error!;
      }

      // Extract and return response data
      if (processedContext.responseData != null) {
        return processedContext.responseData!;
      }

      // Fallback: if chain didn't provide response data, use old method
      final requestHeaders = await _buildHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
        includeContentType: true,
      );

      final response = await RemoteApi.put(
        url,
        body: body,
        headers: requestHeaders,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Makes a DELETE request.
  /// 
  /// [url] - The endpoint URL
  /// [headers] - Optional headers. If provided, used as-is. If null and requiresAuth=true, 
  ///             auth headers are automatically added.
  /// [requiresAuth] - Whether this request requires authentication (default: true)
  /// 
  /// Returns the response data as Map<String, dynamic>
  /// 
  /// This method uses the Chain of Responsibility pattern for request processing.
  static Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    try {
      // Create request context
      final context = RequestContext(
        url: url,
        method: 'DELETE',
        headers: headers,
        requiresAuth: requiresAuth,
      );

      // Process through chain
      final processedContext = await _requestChain.processRequest(context);

      // Handle errors (maintain backward compatibility)
      if (processedContext.hasError) {
        throw processedContext.error!;
      }

      // Extract and return response data
      if (processedContext.responseData != null) {
        return processedContext.responseData!;
      }

      // Fallback: if chain didn't provide response data, use old method
      final requestHeaders = await _buildHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
        includeContentType: true,
      );

      final response = await RemoteApi.delete(
        url,
        headers: requestHeaders,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Makes a POST request with file upload.
  /// 
  /// [url] - The endpoint URL
  /// [fields] - Form fields to send with the file
  /// [filePath] - Path to the file to upload
  /// [filesKey] - Key name for the file in the form data (default: 'image')
  /// [requiresAuth] - Whether this request requires authentication (default: true)
  /// 
  /// Returns the response data as Map<String, dynamic>
  /// 
  /// Note: This method updates the global token variable to maintain compatibility
  /// with RemoteApi.postWithFile which uses the global token internally.
  static Future<Map<String, dynamic>> postWithFile({
    required String url,
    required Map<String, String> fields,
    String? filePath,
    String? filesKey,
    bool requiresAuth = true,
  }) async {
    try {
      if (requiresAuth) {
        // Update global token to ensure RemoteApi.postWithFile uses the latest token
        // This maintains backward compatibility with the current RemoteApi implementation
        // Note: RemoteApi.postWithFile uses the global token variable internally
        token = await SecureStorage.getToken();
      }

      final response = await RemoteApi.postWithFile(
        url: url,
        fields: fields,
        filePath: filePath,
        filesKey: filesKey,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

