import 'dart:developer';

import 'package:fortnite_flutter/core/constants/api_constants.dart';
import 'package:fortnite_flutter/core/network/api_client.dart';
import 'package:fortnite_flutter/data/models/auth_response_model.dart';
import 'package:fortnite_flutter/data/models/user_model.dart';
import 'package:fortnite_flutter/data/services/storage_service.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final StorageService _storageService;

  AuthRepository(this._apiClient, this._storageService);

  // Register
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.register,
        data: {'name': name, 'email': email, 'password': password},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      final user = authResponse.toUserModel();

      // Salvar token e dados do usuário
      await _storageService.saveToken(authResponse.token);
      await _storageService.saveUser(user.toJson());

      return user;
    } catch (e) {
      // Repassa a exceção sem adicionar texto extra
      rethrow;
    }
  }

  // Login
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      log('🔵 Fazendo requisição de login para: $email');
      final response = await _apiClient.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );

      log('✅ Resposta do login recebida: ${response.data}');

      final authResponse = AuthResponseModel.fromJson(response.data);
      final user = authResponse.toUserModel();

      log('🔵 Salvando token e dados do usuário...');
      await _storageService.saveToken(authResponse.token);
      await _storageService.saveUser(user.toJson());
      log('✅ Token e usuário salvos com sucesso');

      return user;
    } catch (e) {
      log('❌ Erro ao fazer login: $e');
      // Repassa a exceção sem adicionar texto extra
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    log('🔵 Limpando dados de autenticação...');
    await _storageService.clearAll();
    log('✅ Dados de autenticação limpos');
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return await _storageService.hasToken();
  }

  // Get current user from storage
  Future<UserModel?> getCurrentUser() async {
    final userData = await _storageService.getUser();
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  // Get current user from API
  Future<UserModel> fetchCurrentUser() async {
    try {
      log('🔵 Buscando usuário atual da API: ${ApiConstants.currentUser}');
      final response = await _apiClient.get(ApiConstants.currentUser);
      log('✅ Resposta da API: ${response.data}');

      final user = UserModel.fromJson(response.data);
      log('✅ UserModel criado: ${user.toJson()}');

      // Atualizar dados do usuário no storage
      await _storageService.saveUser(user.toJson());

      return user;
    } catch (e) {
      log('❌ Erro ao buscar usuário: $e');
      throw Exception('Erro ao buscar usuário: ${e.toString()}');
    }
  }
}
