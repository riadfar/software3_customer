import 'package:dio/dio.dart';
import 'dart:io';
import 'headers.dart';
import 'api_endpoints.dart';

class RemoteApi {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      headers: headersWithContent,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    ),
  )..interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
  ));

  // Helper method to check response status
  static void _checkResponseStatus(int? statusCode) {
    if (statusCode != null && (statusCode < 200 || statusCode >= 300)) {
      throw Exception('Request failed with status code: $statusCode');
    }
  }

  // Helper method to make requests
  static Future<Response> _makeRequest(
      String method,
      String url, {
        dynamic body,
        Map<String, String>? headers,
      }) async {
    try {
      final response = await _dio.request(
        url,
        data: body,
        options: Options(
          method: method,
          headers: headers ?? headersWithAuth(token),
        ),
      );
      _checkResponseStatus(response.statusCode);
      return response;
    } on DioException catch (dioException) {
      print('Dio Error: ${dioException.message}');
      if (dioException.response != null) {
        print('Response data: ${dioException.response?.data}');
        print('Response status: ${dioException.response?.statusCode}');
      }
      rethrow;
    } catch (error) {
      print('Unexpected Error: $error');
      rethrow;
    }
  }

  // POST request
  static Future<Response> post(String url, {dynamic body, Map<String, String>? headers}) async {
    return _makeRequest('POST', url, body: body, headers: headers);
  }

  // PUT request
  static Future<Response> put(String url, {dynamic body, Map<String, String>? headers}) async {
    return _makeRequest('PUT', url, body: body, headers: headers);
  }

  // GET request
  static Future<Response> get(String url, {Map<String, String>? headers}) async {
    return _makeRequest('GET', url, headers: headers);
  }

  // DELETE request
  static Future<Response> delete(String url, {Map<String, String>? headers}) async {
    return _makeRequest('DELETE', url, headers: headers);
  }

  // Helper method to create MultipartFile
  static Future<MultipartFile?> _createMultipartFile(String? filePath, String? fileName) async {
    if (filePath == null) return null;
    return await MultipartFile.fromFile(filePath, filename: fileName);
  }

  // POST request with file upload
  static Future<Response> postWithFile({
    required String url,
    required Map<String, String> fields,
    String? filePath,
    String? filesKey,
  }) async {
    final fileName = filePath?.split(Platform.pathSeparator).last;
    final file = await _createMultipartFile(filePath, fileName);

    final formData = FormData.fromMap({
      ...fields,
      filesKey ?? 'image': file,
    });

    return _makeRequest('POST', url, body: formData, headers: headersWithAuth(token));
  }
}
