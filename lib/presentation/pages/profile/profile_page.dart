import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/cosmetics/cosmetics_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/profile/profile_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/profile/profile_state.dart';
import 'package:fortnite_flutter/presentation/widgets/cosmetic_card.dart';
import 'package:fortnite_flutter/presentation/widgets/custom_app_bar.dart';
import 'package:fortnite_flutter/presentation/widgets/loading_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  Future<void> _returnCosmetic(String cosmeticId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Devolução'),
        content: const Text('Deseja devolver este cosmético?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Devolver'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<CosmeticsCubit>().returnCosmetic(cosmeticId);
      // Reload profile after return
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        context.read<ProfileCubit>().refresh();
        context.read<AuthCubit>().refreshUser();
      }
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Deseja realmente sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<AuthCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'PERFIL',
        showBackButton: false,
        actions: [
          const Text(
            'Sair',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            color: Colors.white,
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const LoadingIndicator(message: 'Carregando perfil...');
          }

          if (state is ProfileError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<ProfileCubit>().refresh(),
            );
          }

          if (state is ProfileLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileCubit>().refresh();
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // User Info Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: FortniteTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: FortniteTheme.neonShadow,
                    ),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: FortniteTheme.darkCard,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: FortniteTheme.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.user.displayName,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  const Shadow(
                                    color: Colors.black,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.user.email,
                          style: TextStyle(
                            color: FortniteTheme.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // V-Bucks
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                color: FortniteTheme.primaryBlue,
                                size: 28,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                state.user.vbucks.toStringAsFixed(0),
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: FortniteTheme.primaryBlue,
                                    ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'V-Bucks',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Cosmetics Section
                  Text(
                    'Meus Cosméticos',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: FortniteTheme.primaryBlue,
                      shadows: [
                        BoxShadow(
                          color: FortniteTheme.primaryBlue.withAlpha(150),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (state.cosmetics.isEmpty)
                    const EmptyStateWidget(
                      message: 'Você ainda não possui cosméticos',
                      icon: Icons.shopping_bag_outlined,
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: state.cosmetics.length,
                      itemBuilder: (context, index) {
                        final userCosmetic = state.cosmetics[index];
                        // Check if cosmetic details are included
                        if (userCosmetic.cosmetic == null) {
                          return const SizedBox.shrink();
                        }
                        return CosmeticCard(
                          cosmetic: userCosmetic.cosmetic!,
                          showPurchaseButton: false,
                          onTap: () => _returnCosmetic(userCosmetic.cosmeticId),
                        );
                      },
                    ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
