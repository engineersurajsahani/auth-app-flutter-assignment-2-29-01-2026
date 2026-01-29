import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void handleRegister() async {
    setState(() => loading = true);

    bool success = await AuthService.register(
      name: nameController.text.trim(),
      username: usernameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() => loading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration successful! Please log in."),
          backgroundColor: Color(0xFFEE6983),
        ),
      );

      await Future.delayed(Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration failed! Try another email."),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF5EE),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 5)
              ],
            ),
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEE6983)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                CustomTextField(controller: nameController, hintText: "Full Name"),
                SizedBox(height: 15),
                CustomTextField(controller: usernameController, hintText: "Username"),
                SizedBox(height: 15),
                CustomTextField(controller: emailController, hintText: "Email"),
                SizedBox(height: 15),
                CustomTextField(controller: passwordController, hintText: "Password", obscureText: true),
                SizedBox(height: 25),
                CustomButton(text: "Register", loading: loading, onPressed: handleRegister),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Color(0xFFEE6983), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
