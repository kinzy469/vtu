import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://10.240.173.137:8000/api'; // Replace with your IP if different

  // Sign Up
  static Future<Map<String, dynamic>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      return json.decode(response.body);
    } catch (e) {
      return {'error': 'Request failed: $e'};
    }
  }

  // Login
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'email': email, 'password': password},
      );

      return json.decode(response.body);
    } catch (e) {
      return {'error': 'Request failed: $e'};
    }
  }

  // Logout
  static Future<Map<String, dynamic>> logout(String token) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/logout"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return json.decode(response.body);
    } catch (e) {
      return {'error': 'Request failed: $e'};
    }
  }
}
