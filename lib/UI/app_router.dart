import 'package:flutter/material.dart';
import 'package:hashplus_flutter/constant/strings.dart' as strings;

import '../UI/welcome.dart';
import '../UI/login.dart';
import '../UI/signup.dart';
import 'mainpage.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case strings.welcome_screen:
        return MaterialPageRoute(builder: (context) => welcome(title: 'MyDay'));

      case strings.login_screen:
        return MaterialPageRoute(builder: (context) => const LoginPage());

      case strings.signup_screen:
        return MaterialPageRoute(builder: (context) => const signup_page());

      case strings.home_screen:
        return MaterialPageRoute(builder: (context) => const Mainpage());

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
