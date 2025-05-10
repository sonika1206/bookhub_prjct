import 'package:bookhub_prjct/models/token.dart';
import 'package:bookhub_prjct/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthService());
});

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? errorMessage;
  final Token? token;

  AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.errorMessage,
    this.token,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? errorMessage,
    Token? token,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      token: token ?? this.token,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState()) {
    checkAuth();
  }

  Future<void> login(String usernames, String password, BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final token = await _authService.login(usernames, password);
      if (token != null) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          token: token,
        );
        context.go('/home');
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Login failed',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> checkAuth() async {
    final token = await _authService.getToken();
    if (token != null) {
      state = state.copyWith(
        isAuthenticated: true,
        token: token,
      );
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = state.copyWith(
      isAuthenticated: false,
      token: null,
      errorMessage: null,
    );
  }
}