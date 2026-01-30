// registration
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import '../services/user_services.dart';
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
      id: "id",
      name: nameController.text,
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    final response = await UserServices.register(user);
    if (response['message']=='User registered successfully'){
      CustomAlertBox.showSuccess(context,'Registration Successful','Your account has been created successfully!',);
      Timer(Duration(seconds:  2),()=>Navigator.pushNamed(context,'/login') );
      
    }else{
      CustomAlertBox.showError(context, "Error", response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              hintText: "Enter Your Name",
              icon: Icon(Icons.person),
            ),
          ),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: "UserName",
              hintText: "Enter your username",
              icon: Icon(Icons.person_add_alt),
            ),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              icon: Icon(Icons.email),
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              icon: Icon(Icons.password),
            ),
          ),
          TextButton(
            onPressed: handleRegister,
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}