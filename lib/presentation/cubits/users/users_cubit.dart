import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/data/repositories/user_repository.dart';
import 'package:fortnite_flutter/presentation/cubits/users/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserRepository _userRepository;

  UsersCubit(this._userRepository) : super(UsersInitial());

  String _cleanErrorMessage(dynamic error) {
    String message = error.toString();
    message = message.replaceFirst('Exception: ', '');
    message = message.replaceFirst('Error: ', '');
    return message;
  }

  // Load all users with their cosmetics
  Future<void> loadUsers() async {
    emit(UsersLoading());
    try {
      final usersDto = await _userRepository.getAllUsers();

      // Convert DTO to state model
      final usersWithCosmetics = usersDto
          .map(
            (dto) =>
                UserWithCosmetics(user: dto.user, cosmetics: dto.cosmetics),
          )
          .toList();

      emit(UsersLoaded(usersWithCosmetics));
    } catch (e) {
      emit(UsersError(_cleanErrorMessage(e)));
    }
  }

  // Refresh users
  Future<void> refresh() async {
    await loadUsers();
  }
}
