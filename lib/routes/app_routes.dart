import 'package:fiap_hackathon/screens/login_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
