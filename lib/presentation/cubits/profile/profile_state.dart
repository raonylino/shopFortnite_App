import 'package:equatable/equatable.dart';
import 'package:fortnite_flutter/data/models/transaction_model.dart';
import 'package:fortnite_flutter/data/models/user_cosmetic_model.dart';
import 'package:fortnite_flutter/data/models/user_model.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final List<UserCosmeticModel> cosmetics; // Changed to UserCosmeticModel
  final List<TransactionModel> transactions;

  ProfileLoaded({
    required this.user,
    required this.cosmetics,
    this.transactions = const [],
  });

  @override
  List<Object?> get props => [user, cosmetics, transactions];

  ProfileLoaded copyWith({
    UserModel? user,
    List<UserCosmeticModel>? cosmetics, // Changed to UserCosmeticModel
    List<TransactionModel>? transactions,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      cosmetics: cosmetics ?? this.cosmetics,
      transactions: transactions ?? this.transactions,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
