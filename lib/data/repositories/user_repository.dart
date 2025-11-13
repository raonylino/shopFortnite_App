import 'dart:developer';

import 'package:fortnite_flutter/core/constants/api_constants.dart';
import 'package:fortnite_flutter/core/network/api_client.dart';
import 'package:fortnite_flutter/data/models/transaction_model.dart';
import 'package:fortnite_flutter/data/models/user_cosmetic_model.dart';
import 'package:fortnite_flutter/data/models/user_model.dart';
import 'package:fortnite_flutter/data/models/user_with_cosmetics_dto.dart';

class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  // Get current user
  Future<UserModel> getCurrentUser() async {
    try {
      log('🔵 Buscando usuário atual em: ${ApiConstants.currentUser}');
      final response = await _apiClient.get(ApiConstants.currentUser);
      log('✅ Resposta recebida: ${response.data}');

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      final userJson = data['user'] as Map<String, dynamic>;
      log('✅ Extraindo dados do objeto user: $userJson');
      return UserModel.fromJson(userJson);
    } catch (e) {
      log('❌ Erro ao buscar usuário atual: $e');
      throw Exception('Erro ao buscar usuário atual: ${e.toString()}');
    }
  }

  // Get user by ID
  Future<UserModel> getUserById(String id) async {
    try {
      final response = await _apiClient.get(ApiConstants.userDetails(id));
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Erro ao buscar usuário: ${e.toString()}');
    }
  }

  // Get all users with their cosmetics
  Future<List<UserWithCosmeticsDto>> getAllUsers() async {
    try {
      final response = await _apiClient.get(ApiConstants.users);
      final List<dynamic> data = response.data;
      return data.map((json) => UserWithCosmeticsDto.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao buscar usuários: ${e.toString()}');
    }
  }

  // Get user cosmetics (detailed with purchase info)
  Future<List<UserCosmeticModel>> getUserCosmetics(String userId) async {
    try {
      final response = await _apiClient.get(ApiConstants.userCosmetics(userId));
      final List<dynamic> data = response.data;
      return data.map((json) => UserCosmeticModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao buscar cosméticos do usuário: ${e.toString()}');
    }
  }

  // Get user transactions
  Future<List<TransactionModel>> getUserTransactions(String userId) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.userTransactions(userId),
      );
      final List<dynamic> data = response.data;
      return data.map((json) => TransactionModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao buscar transações do usuário: ${e.toString()}');
    }
  }
}
