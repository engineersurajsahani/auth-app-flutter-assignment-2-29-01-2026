import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import '../utils/custom_alert_box.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleRegister() async {
    User user = User(
      id: "",
      name: nameController.text,
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    final response = await UserService.register(user);

    if (response['message']
        .toString()
        .toLowerCase()
        .contains('success')) {
      await CustomAlertBox.showSuccess(
        context,
        'Success',
        response['message'],
      );

      Navigator.pushNamed(context, '/login');
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
          "Register",
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
                      "Create Account ✨",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Register to get started",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    // Name
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Username
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        prefixIcon: const Icon(Icons.account_circle),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Email
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Password
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

                    // Register Button
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
                        onPressed: handleRegister,
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, // web-safe
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
