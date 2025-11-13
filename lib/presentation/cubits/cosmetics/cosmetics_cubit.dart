import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/data/models/cosmetic_model.dart';
import 'package:fortnite_flutter/data/repositories/cosmetics_repository.dart';
import 'package:fortnite_flutter/presentation/cubits/cosmetics/cosmetics_state.dart';

class CosmeticsCubit extends Cubit<CosmeticsState> {
  final CosmeticsRepository _cosmeticsRepository;

  CosmeticsCubit(this._cosmeticsRepository) : super(CosmeticsInitial());

  // Helper para limpar mensagens de erro
  String _cleanErrorMessage(dynamic error) {
    String message = error.toString();
    message = message.replaceFirst('Exception: ', '');
    message = message.replaceFirst('Error: ', '');
    return message;
  }

  // Current filters
  String? _currentName;
  String? _currentType;
  String? _currentRarity;
  bool _currentShowOnlyForSale = false;
  bool _currentShowOnlyNew = false;

  // Load cosmetics from local API database
  Future<void> loadCosmetics({
    String? name,
    String? type,
    String? rarity,
    bool showOnlyForSale = false,
    bool showOnlyNew = false,
  }) async {
    emit(CosmeticsLoading());

    // Save current filters
    _currentName = name;
    _currentType = type;
    _currentRarity = rarity;
    _currentShowOnlyForSale = showOnlyForSale;
    _currentShowOnlyNew = showOnlyNew;

    try {
      final cosmetics = await _cosmeticsRepository.getCosmetics();

      // Apply filters
      List<CosmeticModel> filteredCosmetics = cosmetics;

      if (name != null && name.isNotEmpty) {
        filteredCosmetics = filteredCosmetics
            .where((c) => c.name.toLowerCase().contains(name.toLowerCase()))
            .toList();
      }

      if (type != null && type.isNotEmpty) {
        filteredCosmetics = filteredCosmetics
            .where((c) => c.type.toLowerCase() == type.toLowerCase())
            .toList();
      }

      if (rarity != null && rarity.isNotEmpty) {
        filteredCosmetics = filteredCosmetics
            .where((c) => c.rarity.toLowerCase() == rarity.toLowerCase())
            .toList();
      }

      if (showOnlyForSale) {
        filteredCosmetics = filteredCosmetics
            .where((c) => c.isForSale)
            .toList();
      }

      if (showOnlyNew) {
        filteredCosmetics = filteredCosmetics.where((c) => c.isNew).toList();
      }

      emit(
        CosmeticsLoaded(
          cosmetics: filteredCosmetics,
          currentPage: 1,
          totalPages: 1,
          hasMore: false,
        ),
      );
    } catch (e) {
      emit(CosmeticsError(_cleanErrorMessage(e)));
    }
  }

  // Load more cosmetics (pagination) - Not applicable for single API response
  Future<void> loadMoreCosmetics() async {
    // Since we load all items at once, pagination is not applicable
    // This method is kept for interface compatibility but does nothing
    return;
  }

  // Purchase cosmetic
  Future<void> purchaseCosmetic(String cosmeticId) async {
    emit(CosmeticPurchaseLoading());
    try {
      final response = await _cosmeticsRepository.purchaseCosmetic(cosmeticId);
      emit(CosmeticPurchaseSuccess(response.message));

      // Reload cosmetics to update the list
      await loadCosmetics(
        name: _currentName,
        type: _currentType,
        rarity: _currentRarity,
        showOnlyForSale: _currentShowOnlyForSale,
        showOnlyNew: _currentShowOnlyNew,
      );
    } catch (e) {
      emit(CosmeticPurchaseError(_cleanErrorMessage(e)));

      // Restaurar estado anterior
      await loadCosmetics(
        name: _currentName,
        type: _currentType,
        rarity: _currentRarity,
        showOnlyForSale: _currentShowOnlyForSale,
        showOnlyNew: _currentShowOnlyNew,
      );
    }
  }

  // Return cosmetic
  Future<void> returnCosmetic(String cosmeticId) async {
    emit(CosmeticPurchaseLoading());
    try {
      final response = await _cosmeticsRepository.returnCosmetic(cosmeticId);
      emit(CosmeticPurchaseSuccess(response.message));

      // Reload cosmetics to update the list
      await loadCosmetics(
        name: _currentName,
        type: _currentType,
        rarity: _currentRarity,
        showOnlyForSale: _currentShowOnlyForSale,
        showOnlyNew: _currentShowOnlyNew,
      );
    } catch (e) {
      emit(CosmeticPurchaseError(_cleanErrorMessage(e)));

      // Restaurar estado anterior
      await loadCosmetics(
        name: _currentName,
        type: _currentType,
        rarity: _currentRarity,
        showOnlyForSale: _currentShowOnlyForSale,
        showOnlyNew: _currentShowOnlyNew,
      );
    }
  }

  // Refresh cosmetics
  Future<void> refresh() async {
    await loadCosmetics(
      name: _currentName,
      type: _currentType,
      rarity: _currentRarity,
      showOnlyForSale: _currentShowOnlyForSale,
      showOnlyNew: _currentShowOnlyNew,
    );
  }
}
