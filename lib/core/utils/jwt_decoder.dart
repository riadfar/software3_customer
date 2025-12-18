import 'dart:convert';

class JwtDecoder {
  /// Decodes a JWT token and returns the payload as a Map
  static Map<String, dynamic>? decode(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      // Decode the payload (second part)
      final payload = parts[1];
      // Add padding if needed
      String normalizedPayload = payload;
      switch (payload.length % 4) {
        case 1:
          normalizedPayload += '===';
          break;
        case 2:
          normalizedPayload += '==';
          break;
        case 3:
          normalizedPayload += '=';
          break;
      }

      final decoded = utf8.decode(base64Url.decode(normalizedPayload));
      return json.decode(decoded) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Checks if the user has admin role from JWT token
  static bool isAdmin(String? token) {
    if (token == null) return false;
    
    final payload = decode(token);
    if (payload == null) return false;

    // Check for role claim (can be in different formats)
    final role = payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] ??
                 payload['role'] ??
                 payload['Role'];
    
    if (role is String) {
      return role.toLowerCase() == 'admin';
    } else if (role is List) {
      return role.any((r) => r.toString().toLowerCase() == 'admin');
    }
    
    return false;
  }

  /// Gets user ID from JWT token
  static String? getUserId(String? token) {
    if (token == null) return null;
    
    final payload = decode(token);
    if (payload == null) return null;

    return payload['sub']?.toString() ??
           payload['userId']?.toString() ??
           payload['UserId']?.toString() ??
           payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']?.toString();
  }
}

