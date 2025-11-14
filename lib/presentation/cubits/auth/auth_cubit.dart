import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/data/models/user_model.dart';
import 'package:fortnite_flutter/data/repositories/auth_repository.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  // Check authentication status
  Future<void> checkAuthStatus() async {
    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      if (isAuthenticated) {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  String _cleanErrorMessage(dynamic error) {
    String message = error.toString();
    message = message.replaceFirst('Exception: ', '');
    message = message.replaceFirst('Error: ', '');
    return message;
  }

  // Login
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(_cleanErrorMessage(e)));
      await Future.delayed(const Duration(milliseconds: 100));
      emit(AuthUnauthenticated());
    }
  }

  // Register
  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.register(
        name: name,
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(_cleanErrorMessage(e)));
      emit(AuthUnauthenticated());
    }
  }

  // Logout
  Future<void> logout() async {
    await _authRepository.logout();
    emit(AuthUnauthenticated());
  }

  // Refresh user data
  Future<void> refreshUser() async {
    try {
      final user = await _authRepository.fetchCurrentUser();
      emit(AuthAuthenticated(user));
    } catch (e) {
      // Manter estado atual em caso de erro
    }
  }

  // Update user in state
  void updateUser(UserModel user) {
    emit(AuthAuthenticated(user));
  }
}
