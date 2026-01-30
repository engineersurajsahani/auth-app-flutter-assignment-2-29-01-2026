import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {
  static String baseUrl = 'http://localhost:8080/api';

  // Register a new user
  Future<Map<String, dynamic>> register(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Failed to register');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Login user
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Store token
        final prefs = await SharedPreferences.getInstance();
        if (responseData['token'] != null) {
          await prefs.setString('token', responseData['token']);

          // You can also decode it immediately if needed
          Map<String, dynamic> decodedToken = JwtDecoder.decode(
            responseData['token'],
          );
          print("Decoded Token: $decodedToken");
        }

        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Failed to login');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Get stored token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Get User ID from stored token
  Future<String?> getUserIdFromToken() async {
    final token = await getToken();
    if (token != null && !JwtDecoder.isExpired(token)) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken['id']; // Assuming the payload has an 'id' field
    }
    return null;
  }

  // Get user profile
  Future<User> getUserProfile(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profile/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData.containsKey('user')) {
          return User.fromJson(responseData['user']);
        } else if (responseData.containsKey('name') ||
            responseData.containsKey('username')) {
          return User.fromJson(responseData);
        } else {
          throw Exception("User data not found in response");
        }
      } else {
        throw Exception(responseData['message'] ?? 'Failed to get profile');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
