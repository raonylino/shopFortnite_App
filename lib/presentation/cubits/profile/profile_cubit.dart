import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/data/repositories/user_repository.dart';
import 'package:fortnite_flutter/presentation/cubits/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;

  ProfileCubit(this._userRepository) : super(ProfileInitial());

  // Helper para limpar mensagens de erro
  String _cleanErrorMessage(dynamic error) {
    String message = error.toString();
    message = message.replaceFirst('Exception: ', '');
    message = message.replaceFirst('Error: ', '');
    return message;
  }

  // Load profile
  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final user = await _userRepository.getCurrentUser();
      final cosmetics = await _userRepository.getUserCosmetics(user.id);
      final transactions = await _userRepository.getUserTransactions(user.id);

      emit(
        ProfileLoaded(
          user: user,
          cosmetics: cosmetics,
          transactions: transactions,
        ),
      );
    } catch (e) {
      emit(ProfileError(_cleanErrorMessage(e)));
    }
  }

  // Refresh profile
  Future<void> refresh() async {
    await loadProfile();
  }

  // Load user cosmetics only
  Future<void> loadCosmetics() async {
    final currentState = state;
    if (currentState is! ProfileLoaded) {
      return;
    }

    try {
      final cosmetics = await _userRepository.getUserCosmetics(
        currentState.user.id,
      );
      emit(currentState.copyWith(cosmetics: cosmetics));
    } catch (e) {
      emit(ProfileError(_cleanErrorMessage(e)));
    }
  }

  // Load user transactions only
  Future<void> loadTransactions() async {
    final currentState = state;
    if (currentState is! ProfileLoaded) {
      return;
    }

    try {
      final transactions = await _userRepository.getUserTransactions(
        currentState.user.id,
      );
      emit(currentState.copyWith(transactions: transactions));
    } catch (e) {
      emit(ProfileError(_cleanErrorMessage(e)));
    }
  }
}
