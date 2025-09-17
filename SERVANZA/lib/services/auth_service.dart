import 'dart:async';

import '../models/auth.dart';

class MockAuthService {
  Future<AuthUser> signIn({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (email.isEmpty || password.isEmpty) {
      throw AuthException('Please enter email and password.');
    }
    if (!email.contains('@')) {
      throw AuthException('Enter a valid email address.');
    }
    if (password.length < 6) {
      throw AuthException('Password must be at least 6 characters.');
    }
    return AuthUser(id: 'u_123', email: email);
  }

  Future<AuthUser> signUp({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.isEmpty || password.isEmpty) {
      throw AuthException('Please enter email and password.');
    }
    if (!email.contains('@')) {
      throw AuthException('Enter a valid email address.');
    }
    if (password.length < 6) {
      throw AuthException('Password must be at least 6 characters.');
    }
    return AuthUser(id: 'u_new', email: email);
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}


