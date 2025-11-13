import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';
import 'package:fortnite_flutter/core/utils/snackbar_helper.dart';
import 'package:fortnite_flutter/data/models/cosmetic_model.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/cosmetics/cosmetics_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/cosmetics/cosmetics_state.dart';

class CosmeticDetailPage extends StatelessWidget {
  final CosmeticModel cosmetic;

  const CosmeticDetailPage({super.key, required this.cosmetic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FortniteTheme.darkBackground,
      body: BlocListener<CosmeticsCubit, CosmeticsState>(
        listener: (context, state) {
          if (state is CosmeticPurchaseSuccess) {
            SnackbarHelper.showSuccess(context, state.message);
            context.read<AuthCubit>().refreshUser();
            Navigator.pop(context);
          } else if (state is CosmeticPurchaseError) {
            SnackbarHelper.showError(context, state.message);
          }
        },
        child: CustomScrollView(
          slivers: [
            // App Bar with Image
            SliverAppBar(
              expandedHeight: 400,
              pinned: true,
              backgroundColor: FortniteTheme.darkCard,
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background gradient
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            FortniteTheme.getRarityColor(
                              cosmetic.rarity,
                            ).withAlpha(100),
                            FortniteTheme.darkBackground,
                          ],
                        ),
                      ),
                    ),
                    // Image
                    CachedNetworkImage(
                      imageUrl: cosmetic.imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error_outline,
                          size: 64,
                          color: FortniteTheme.textSecondary,
                        ),
                      ),
                    ),
                    // Gradient overlay at bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              FortniteTheme.darkCard,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content
            SliverToBoxAdapter(
              child: Container(
                color: FortniteTheme.darkCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title Section
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badges
                          Row(
                            children: [
                              // Rarity Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: FortniteTheme.getRarityColor(
                                    cosmetic.rarity,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: FortniteTheme.getRarityColor(
                                        cosmetic.rarity,
                                      ).withAlpha(150),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  cosmetic.rarity.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // New Badge
                              if (cosmetic.isNew)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.redAccent.withAlpha(150),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    'NOVO',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 12),
                              // For Sale Badge
                              if (cosmetic.isForSale)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withAlpha(150),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    'À VENDA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Name
                          Text(
                            cosmetic.name,
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: FortniteTheme.getRarityColor(
                                    cosmetic.rarity,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  shadows: [
                                    Shadow(
                                      color: FortniteTheme.getRarityColor(
                                        cosmetic.rarity,
                                      ).withAlpha(200),
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                          ),
                          const SizedBox(height: 8),
                          // Type
                          Text(
                            cosmetic.type,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: FortniteTheme.textSecondary,
                                  fontSize: 18,
                                ),
                          ),
                          const SizedBox(height: 24),
                          // Divider
                          Container(
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FortniteTheme.getRarityColor(
                                    cosmetic.rarity,
                                  ).withAlpha(0),
                                  FortniteTheme.getRarityColor(cosmetic.rarity),
                                  FortniteTheme.getRarityColor(
                                    cosmetic.rarity,
                                  ).withAlpha(0),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Description
                          if (cosmetic.description != null &&
                              cosmetic.description!.isNotEmpty) ...[
                            Text(
                              'Descrição',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: FortniteTheme.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              cosmetic.description!,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: FortniteTheme.textSecondary,
                                    height: 1.5,
                                  ),
                            ),
                            const SizedBox(height: 24),
                          ],
                          // Details Grid
                          Text(
                            'Detalhes',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: FortniteTheme.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 12),
                          _DetailItem(
                            icon: Icons.category,
                            label: 'Tipo',
                            value: cosmetic.type,
                          ),
                          _DetailItem(
                            icon: Icons.diamond,
                            label: 'Raridade',
                            value: cosmetic.rarity,
                            valueColor: FortniteTheme.getRarityColor(
                              cosmetic.rarity,
                            ),
                          ),
                          _DetailItem(
                            icon: Icons.monetization_on,
                            label: 'Preço',
                            value:
                                '${cosmetic.price.toStringAsFixed(0)} V-Bucks',
                            valueColor: FortniteTheme.primaryBlue,
                          ),
                          if (cosmetic.apiId != null)
                            _DetailItem(
                              icon: Icons.fingerprint,
                              label: 'ID',
                              value: cosmetic.apiId!,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Purchase Button
      bottomNavigationBar: cosmetic.isForSale
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: FortniteTheme.darkCard,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _showPurchaseDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FortniteTheme.primaryPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_cart, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          'COMPRAR POR ${cosmetic.price.toStringAsFixed(0)} V-BUCKS',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Future<void> _showPurchaseDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: FortniteTheme.darkCard,
        title: const Text(
          'Confirmar Compra',
          style: TextStyle(color: FortniteTheme.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Deseja comprar ${cosmetic.name}?',
              style: const TextStyle(color: FortniteTheme.textSecondary),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.monetization_on,
                  color: FortniteTheme.primaryBlue,
                  size: 32,
                ),
                const SizedBox(width: 8),
                Text(
                  cosmetic.price.toStringAsFixed(0),
                  style: const TextStyle(
                    color: FortniteTheme.primaryBlue,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: FortniteTheme.primaryPurple,
            ),
            child: const Text('Comprar'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<CosmeticsCubit>().purchaseCosmetic(cosmetic.id);
    }
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: FortniteTheme.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: FortniteTheme.primaryBlue.withAlpha(100),
              ),
            ),
            child: Icon(icon, color: FortniteTheme.primaryBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: FortniteTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: valueColor ?? FortniteTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
