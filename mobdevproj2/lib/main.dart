import 'package:flutter/material.dart';
import 'signup_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
       
      ),
      home: SignUpPage(), //signuppage as home temporarily
    );
  }
}
