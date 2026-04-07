import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? error;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final user = await _authService.login(
        email.trim(),
        password.trim(),
      );

      return user != null;
    } on FirebaseAuthException catch (e) {
      error = e.message;
      return false;
    } catch (e) {
      error = "Something went wrong";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final user = await _authService.register(
        name.trim(),
        email.trim(),
        password.trim(),
      );

      return user != null;
    } on FirebaseAuthException catch (e) {
      error = e.message;
      return false;
    } catch (e) {
      error = "Something went wrong";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}