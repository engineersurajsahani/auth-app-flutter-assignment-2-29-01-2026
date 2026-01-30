// login 
import 'dart:async';

import 'package:flutter/material.dart';
import '../services/user_services.dart';
import '../utils/custom_alert_box.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {



  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void handleLogin() async {

    final response = await UserServices.login(usernameController.text,passwordController.text);
    print(response);
    if (response['message']=='Login successful'){
      String token=response['token'];
      Map<String,dynamic> decodedToken= Jwt.parseJwt(token);
      print("decoded Token : $decodedToken");
      User user = User(
        id: decodedToken["userId"],
        name: decodedToken['name'],
        username: decodedToken['username'],
        email: decodedToken['email'],
        password: ""
      );
      CustomAlertBox.showSuccess(
        context,
        'Successful',
        'Your account has been created successfully!',
      );
      Timer(Duration(seconds:  2),()=>Navigator.pushNamed(context,'/profile',arguments: user) );
    }else{
      CustomAlertBox.showError(context, "Error", response['message']);
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: "UserName",
              hintText: "Enter your username",
              icon: Icon(Icons.person_add_alt),
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
            onPressed: handleLogin,
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}