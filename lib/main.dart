import 'package:flutter/material.dart';
import 'package:hashplus_flutter/UI/welcome.dart';
import 'package:hashplus_flutter/UI/login.dart';
import 'package:hashplus_flutter/UI/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        '/': (context) => welcome(title: 'MyDay'),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const signup_page(),
      },

      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}
