import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          TextButton(onPressed: ()=>Navigator.pushNamed(context , '/register'), child: Text("Register")),
          TextButton(onPressed: ()=>Navigator.pushNamed(context , '/login'), child: Text("Login")),
          TextButton(onPressed: ()=>Navigator.pushNamed(context , '/profile'), child: Text("Profile"))
        ],
      ),
    );
  }
}