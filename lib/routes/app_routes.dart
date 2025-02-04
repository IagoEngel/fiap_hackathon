import 'package:fiap_hackathon/screens/home/home_screen.dart';
import 'package:fiap_hackathon/screens/login/login_screen.dart';
import 'package:fiap_hackathon/screens/register/register_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/register':
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
