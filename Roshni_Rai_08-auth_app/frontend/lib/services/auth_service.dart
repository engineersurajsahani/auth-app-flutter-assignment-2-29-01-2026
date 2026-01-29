import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "http://localhost:5050/api/auth";

  // Register user
  static Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      print("Register response: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Register error: $e");
      return false;
    }
  }

  // Login user
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print("Login response: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(data['user']));
        await prefs.setString('token', data['token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  // Get logged-in user
  static Future<Map<String, dynamic>?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    if (user != null) return jsonDecode(user);
    return null;
  }

  // Logout user
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
