import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/core/constants/app_constants.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';
import 'package:fortnite_flutter/core/utils/snackbar_helper.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/cosmetics/cosmetics_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/cosmetics/cosmetics_state.dart';
import 'package:fortnite_flutter/presentation/pages/cosmetic_detail/cosmetic_detail_page.dart';
import 'package:fortnite_flutter/presentation/widgets/cosmetic_card.dart';
import 'package:fortnite_flutter/presentation/widgets/custom_app_bar.dart';
import 'package:fortnite_flutter/presentation/widgets/loading_widget.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounceTimer;

  String? _selectedType;
  String? _selectedRarity;
  bool _showOnlyForSale = false;
  bool _showOnlyNew = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
    context.read<CosmeticsCubit>().loadCosmetics();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    // Cancela o timer anterior se existir
    _debounceTimer?.cancel();

    // Cria um novo timer de 2 segundos
    _debounceTimer = Timer(const Duration(seconds: 2), () {
      _applyFilters();
    });
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CosmeticsCubit>().loadMoreCosmetics();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _applyFilters() {
    context.read<CosmeticsCubit>().loadCosmetics(
      name: _searchController.text.isEmpty ? null : _searchController.text,
      type: _selectedType,
      rarity: _selectedRarity,
      showOnlyForSale: _showOnlyForSale,
      showOnlyNew: _showOnlyNew,
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Filtros'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type Filter
                const Text('Tipo:'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('Todos'),
                      selected: _selectedType == null,
                      onSelected: (selected) {
                        setState(() {
                          _selectedType = null;
                        });
                        Navigator.pop(context);
                        _applyFilters();
                      },
                    ),
                    ...AppConstants.cosmeticTypes.map(
                      (type) => FilterChip(
                        label: Text(type),
                        selected: _selectedType == type,
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = selected ? type : null;
                          });
                          Navigator.pop(context);
                          _applyFilters();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Rarity Filter
                const Text('Raridade:'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('Todas'),
                      selected: _selectedRarity == null,
                      onSelected: (selected) {
                        setState(() {
                          _selectedRarity = null;
                        });
                        Navigator.pop(context);
                        _applyFilters();
                      },
                    ),
                    ...AppConstants.cosmeticRarities.map(
                      (rarity) => FilterChip(
                        label: Text(rarity),
                        backgroundColor: FortniteTheme.getRarityColor(rarity),
                        selected: _selectedRarity == rarity,
                        onSelected: (selected) {
                          setState(() {
                            _selectedRarity = selected ? rarity : null;
                          });
                          Navigator.pop(context);
                          _applyFilters();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // For Sale Filter
                SwitchListTile(
                  title: const Text('Apenas à venda'),
                  value: _showOnlyForSale,
                  onChanged: (value) {
                    setDialogState(() {
                      setState(() {
                        _showOnlyForSale = value;
                      });
                    });
                  },
                ),

                // New Items Filter
                SwitchListTile(
                  title: const Text('Apenas novos'),
                  value: _showOnlyNew,
                  onChanged: (value) {
                    setDialogState(() {
                      setState(() {
                        _showOnlyNew = value;
                      });
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _applyFilters();
              },
              child: const Text('Aplicar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _purchaseCosmetic(String cosmeticId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Compra'),
        content: const Text('Deseja comprar este cosmético?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Comprar'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<CosmeticsCubit>().purchaseCosmetic(cosmeticId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'LOJA DE ITENS',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
            color: FortniteTheme.textPrimary,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar cosmético...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Cosmetics Grid
          Expanded(
            child: BlocConsumer<CosmeticsCubit, CosmeticsState>(
              listener: (context, state) {
                if (state is CosmeticPurchaseSuccess) {
                  SnackbarHelper.showSuccess(context, state.message);
                  // Refresh user data
                  context.read<AuthCubit>().refreshUser();
                } else if (state is CosmeticPurchaseError) {
                  SnackbarHelper.showError(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is CosmeticsLoading) {
                  return const LoadingWidget(isGrid: true);
                }

                if (state is CosmeticsError) {
                  return ErrorStateWidget(
                    message: state.message,
                    onRetry: _applyFilters,
                  );
                }

                if (state is CosmeticsLoaded) {
                  if (state.cosmetics.isEmpty) {
                    return const EmptyStateWidget(
                      message: 'Nenhum cosmético encontrado',
                      icon: Icons.search_off,
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CosmeticsCubit>().refresh();
                    },
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount:
                          state.cosmetics.length +
                          (state.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.cosmetics.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final cosmetic = state.cosmetics[index];
                        return CosmeticCard(
                          cosmetic: cosmetic,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CosmeticDetailPage(cosmetic: cosmetic),
                              ),
                            );
                          },
                          onPurchase: () => _purchaseCosmetic(cosmetic.id),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
