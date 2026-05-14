import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final String apiRoot;

  ApiClient({required this.apiRoot});

  Future<dynamic> request({
    required String httpMethod,
    required String apiPath,
    dynamic data,
  }) async {
    final uri = Uri.parse('$apiRoot$apiPath');
    final headers = {'Content-Type': 'application/json'};

    http.Response response;

    switch (httpMethod.toUpperCase()) {
      case 'GET':
        response = await http.get(uri, headers: headers);
      case 'POST':
        response = await http.post(uri, headers: headers, body: jsonEncode(data));
      case 'PUT':
        response = await http.put(uri, headers: headers, body: jsonEncode(data));
      case 'DELETE':
        response = await http.delete(uri, headers: headers);
      default:
        throw Exception('Unsupported HTTP method: $httpMethod');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw Exception('Request failed: ${response.statusCode} ${response.body}');
    }
  }
}