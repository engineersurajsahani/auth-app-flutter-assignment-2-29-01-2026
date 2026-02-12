import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFEE6983),
        scaffoldBackgroundColor: Color(0xFFFCF5EE),
      ),
      home: LoginScreen(),
    );
  }
}
