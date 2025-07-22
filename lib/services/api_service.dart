import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Replace with your actual Laragon IP address
  static const String baseUrl = "http://YOUR_LOCAL_IP/api_service";

  // Signup
  static Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/register"),
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'status': false, 'message': 'Error: $e'};
    }
  }

  // Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/login"),
        body: {
          'email': email,
          'password': password,
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'status': false, 'message': 'Error: $e'};
    }
  }
}
