import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthViewModel({AuthService? authService})
    : _authService = authService ?? AuthService();

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> login(String email, String password) async {
    final e = email.trim();
    final p = password.trim();

    if (e.isEmpty || p.isEmpty) {
      _setError("Email and password are required");
      return false;
    }

    _setLoading(true);
    _setError(null);

    try {
      final user = await _authService.login(e, p);
      return user != null;
    } on FirebaseAuthException catch (ex) {
      _setError(ex.message ?? "Login failed");
      return false;
    } catch (_) {
      _setError("Something went wrong. Please try again.");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register(String name, String email, String password) async {
    final n = name.trim();
    final e = email.trim();
    final p = password.trim();

    if (n.isEmpty || e.isEmpty || p.isEmpty) {
      _setError("All fields are required");
      return false;
    }

    if (p.length < 6) {
      _setError("Password must be at least 6 characters");
      return false;
    }

    _setLoading(true);
    _setError(null);

    try {
      final user = await _authService.register(n, e, p);
      return user != null;
    } on FirebaseAuthException catch (ex) {
      _setError(ex.message ?? "Registration failed");
      return false;
    } catch (_) {
      _setError("Something went wrong. Please try again.");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }
}
