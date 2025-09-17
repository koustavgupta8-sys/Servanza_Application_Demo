import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<MockAuthService>((ref) => MockAuthService());

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final service = ref.watch(authServiceProvider);
  return AuthController(service);
});

class AuthController extends StateNotifier<AuthState> {
  final MockAuthService service;

  AuthController(this.service) : super(const AuthState());

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await service.signIn(email: email, password: password);
      state = AuthState(user: user, isLoading: false);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, errorMessage: 'Something went wrong.');
    }
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await service.signUp(email: email, password: password);
      state = AuthState(user: user, isLoading: false);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, errorMessage: 'Something went wrong.');
    }
  }

  Future<void> signOut() async {
    await service.signOut();
    state = const AuthState();
  }
}


