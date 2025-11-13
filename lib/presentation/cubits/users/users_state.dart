import 'package:equatable/equatable.dart';
import 'package:fortnite_flutter/data/models/cosmetic_model.dart';
import 'package:fortnite_flutter/data/models/user_model.dart';

class UserWithCosmetics extends Equatable {
  final UserModel user;
  final List<CosmeticModel> cosmetics;

  const UserWithCosmetics({required this.user, required this.cosmetics});

  @override
  List<Object?> get props => [user, cosmetics];
}

abstract class UsersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserWithCosmetics> users;

  UsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class UsersError extends UsersState {
  final String message;

  UsersError(this.message);

  @override
  List<Object?> get props => [message];
}
