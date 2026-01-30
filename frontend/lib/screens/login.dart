import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import '../utils/custom_alert_box.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void handleLogin() async {
    final response = await UserService.login(
      usernameController.text,
      passwordController.text,
    );

    if (response['message'] == 'Login successful') {
      String token = response['token'];
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

      User user = User(
        id: decodedToken['userId'],
        name: decodedToken['name'],
        username: decodedToken['username'],
        email: decodedToken['email'],
        password: "",
      );

      CustomAlertBox.showSuccess(
        context,
        'Success',
        response['message'],
      );

      Navigator.pushNamed(
        context,
        '/profile',
        arguments: user,
      );
    } else {
      CustomAlertBox.showError(
        context,
        'Error',
        response['message'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const Text(
                      "Welcome Back 👋",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Login to your account",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    // Username Field
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Password Field
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: handleLogin,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, // 🔥 Web-safe
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
