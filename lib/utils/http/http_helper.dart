import 'dart:convert';

import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseurl =
      'https://jsonplaceholder.typicode.com'; // replace with your base url

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseurl/$endpoint'));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic body) async {
    final response =
        await http.post(Uri.parse('$_baseurl/$endpoint'), body: body);
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed To Load Data: ${response.statusCode}');
    }
  }
}
