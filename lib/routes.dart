import 'package:first_task/modules/auth/login_screen.dart';
import 'package:first_task/modules/auth/register_screen.dart';
import 'package:first_task/modules/home/home_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String loginScreen = '/';
  static const String registerScreen = '/register';
  static const String honeScreen = '/home';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case honeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        throw const FormatException("Route not found");
    }
  }
}
