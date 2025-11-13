import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';
import 'package:fortnite_flutter/data/models/cosmetic_model.dart';

class CosmeticCard extends StatelessWidget {
  final CosmeticModel cosmetic;
  final VoidCallback? onTap;
  final VoidCallback? onPurchase;
  final bool showPurchaseButton;

  const CosmeticCard({
    super.key,
    required this.cosmetic,
    this.onTap,
    this.onPurchase,
    this.showPurchaseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: FortniteTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            FortniteTheme.getRarityShadow(cosmetic.rarity),
            ...FortniteTheme.neonShadow,
          ],
          border: Border.all(
            color: FortniteTheme.getRarityColor(cosmetic.rarity).withAlpha(170),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: cosmetic.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Container(
                        color: FortniteTheme.darkCard,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: FortniteTheme.darkCard,
                        child: const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: FortniteTheme.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  // Badges
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Row(
                      children: [
                        // Rarity Badge
                        _RarityBadge(rarity: cosmetic.rarity),
                        const SizedBox(width: 8),
                        // New Badge
                        if (cosmetic.isNew)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'NOVO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cosmetic.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: FortniteTheme.getRarityColor(cosmetic.rarity),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: FortniteTheme.getRarityColor(
                            cosmetic.rarity,
                          ).withAlpha(150),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cosmetic.type,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: FortniteTheme.primaryBlue,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cosmetic.price.toStringAsFixed(0),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: FortniteTheme.primaryBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      // Purchase Button
                      if (showPurchaseButton &&
                          cosmetic.isForSale &&
                          onPurchase != null)
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            onPressed: onPurchase,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              backgroundColor: FortniteTheme.primaryPurple,
                            ),
                            child: const Text(
                              'Comprar',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RarityBadge extends StatelessWidget {
  final String rarity;

  const _RarityBadge({required this.rarity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: FortniteTheme.getRarityColor(rarity),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: FortniteTheme.getRarityColor(rarity).withAlpha(170),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        rarity.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: Colors.black, blurRadius: 4)],
        ),
      ),
    );
  }
}
