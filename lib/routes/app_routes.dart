import 'package:flutter/material.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/home/home_screen.dart';
import '../features/product/product_detail_screen.dart';

class AppRoutes {
  static const String login = "/";
  static const String register = "/register";
  static const String home = "/home";
  static const String product = "/product";

  static Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    home: (_) => const HomeScreen(),
    product: (_) => const ProductDetailScreen(),
  };
}