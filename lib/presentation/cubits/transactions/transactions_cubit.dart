import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/data/repositories/transaction_repository.dart';
import 'package:fortnite_flutter/presentation/cubits/transactions/transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionRepository _repository;

  TransactionsCubit(this._repository) : super(const TransactionsInitial());

  String _cleanErrorMessage(dynamic error) {
    String message = error.toString();
    message = message.replaceFirst('Exception: ', '');
    message = message.replaceFirst('Error: ', '');
    return message;
  }

  /// Carrega todas as transações do usuário logado
  Future<void> loadTransactions() async {
    try {
      emit(const TransactionsLoading());
      final transactions = await _repository.getMyTransactions();
      emit(TransactionsLoaded(transactions));
    } catch (e) {
      emit(TransactionsError(_cleanErrorMessage(e)));
    }
  }

  /// Recarrega as transações (pull to refresh)
  Future<void> refresh() async {
    await loadTransactions();
  }
}
