import 'package:fortnite_flutter/core/constants/api_constants.dart';
import 'package:fortnite_flutter/core/network/api_client.dart';
import 'package:fortnite_flutter/data/models/transaction_model.dart';

class TransactionRepository {
  final ApiClient _apiClient;

  TransactionRepository(this._apiClient);

  /// Busca todas as transações do usuário logado
  Future<List<TransactionModel>> getMyTransactions() async {
    try {
      final userResponse = await _apiClient.get(ApiConstants.currentUser);
      final Map<String, dynamic> userData =
          userResponse.data as Map<String, dynamic>;
      final String userId =
          (userData['user'] as Map<String, dynamic>)['id'] as String;

      final response = await _apiClient.get(
        ApiConstants.userTransactions(userId),
      );

      if (response.data is List) {
        final transactions = (response.data as List)
            .map(
              (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();

        transactions.sort((a, b) => b.date.compareTo(a.date));

        return transactions;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}
