import 'package:equatable/equatable.dart';
import 'package:fortnite_flutter/data/models/transaction_model.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

class TransactionsInitial extends TransactionsState {
  const TransactionsInitial();
}

class TransactionsLoading extends TransactionsState {
  const TransactionsLoading();
}

class TransactionsLoaded extends TransactionsState {
  final List<TransactionModel> transactions;

  const TransactionsLoaded(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class TransactionsError extends TransactionsState {
  final String message;

  const TransactionsError(this.message);

  @override
  List<Object?> get props => [message];
}
