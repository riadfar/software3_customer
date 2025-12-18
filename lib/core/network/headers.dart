Map<String, String> headersWithAuthContent(String token) => {
  ...headersWithAuth(token),
  'Content-Type': 'application/json',
};

Map<String, String> headersWithAuth(String token) => {
  'Accept': 'application/json',
  'Authorization': 'Bearer $token',
};

Map<String, String> headersWithContent = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

Map<String, String> headers = {
  'Accept': 'application/json',
};
