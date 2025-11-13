import 'dart:developer';

import 'package:fortnite_flutter/core/constants/api_constants.dart';
import 'package:fortnite_flutter/core/network/api_client.dart';
import 'package:fortnite_flutter/data/models/cosmetic_model.dart';
import 'package:fortnite_flutter/data/models/purchase_response_model.dart';

class CosmeticsRepository {
  final ApiClient _apiClient;

  CosmeticsRepository(this._apiClient);

  Future<List<CosmeticModel>> getCosmetics() async {
    try {
      // Adiciona parâmetros para buscar todos os itens (sem paginação ou com limite alto)
      final response = await _apiClient.get(
        '${ApiConstants.cosmetics}?pageSize=20000&page=1',
      );

      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      final List<dynamic> items = responseData['items'] as List<dynamic>;

      log('Total de cosméticos carregados: ${items.length}');
      return items.map((json) => CosmeticModel.fromJson(json)).toList();
    } catch (e) {
      log(e.toString());
      throw Exception('Erro ao buscar cosméticos: ${e.toString()}');
    }
  }

  Future<CosmeticModel?> getCosmeticDetails(String cosmeticId) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.cosmeticDetails(cosmeticId),
      );
      if (response.data != null) {
        return CosmeticModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao buscar detalhes do cosmético: ${e.toString()}');
    }
  }

  Future<PurchaseResponseModel> purchaseCosmetic(String cosmeticId) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.purchaseCosmetic(cosmeticId),
      );
      return PurchaseResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Erro ao comprar cosmético: ${e.toString()}');
    }
  }

  Future<PurchaseResponseModel> returnCosmetic(String cosmeticId) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.returnCosmetic(cosmeticId),
      );
      return PurchaseResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Erro ao devolver cosmético: ${e.toString()}');
    }
  }
}
