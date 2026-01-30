import 'package:flutter/material.dart';
import 'package:frontend/screens/login.dart';
import 'package:frontend/screens/registration.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Auth App",
      initialRoute: '/',
      routes: {
        '/':(context)=>HomeScreen(),
        '/register':(context)=> RegistrationScreen(),
        '/login':(context)=> LoginScreen(),
        '/profile':(context)=> ProfileScreen(),
      }
    );
  }
}
