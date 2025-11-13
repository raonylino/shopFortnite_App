import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';
import 'package:fortnite_flutter/presentation/cubits/users/users_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/users/users_state.dart';
import 'package:fortnite_flutter/presentation/widgets/custom_app_bar.dart';
import 'package:fortnite_flutter/presentation/widgets/loading_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'USUÁRIOS', showBackButton: false),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const LoadingIndicator(message: 'Carregando usuários...');
          }

          if (state is UsersError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<UsersCubit>().refresh(),
            );
          }

          if (state is UsersLoaded) {
            if (state.users.isEmpty) {
              return const EmptyStateWidget(
                message: 'Nenhum usuário encontrado',
                icon: Icons.people_outline,
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<UsersCubit>().refresh();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final userWithCosmetics = state.users[index];
                  final user = userWithCosmetics.user;
                  final cosmetics = userWithCosmetics.cosmetics;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: FortniteTheme.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: FortniteTheme.neonShadow,
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: FortniteTheme.primaryPurple,
                        child: Text(
                          user.displayName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        user.displayName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                color: FortniteTheme.primaryBlue,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${user.vbucks.toStringAsFixed(0)} V-Bucks',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: FortniteTheme.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      children: [
                        if (cosmetics.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Nenhum cosmético adquirido',
                              style: TextStyle(
                                color: FortniteTheme.textSecondary,
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: FortniteTheme.darkCard,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cosméticos (${cosmetics.length})',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: FortniteTheme.primaryBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                // Cosmetics Table
                                Table(
                                  border: TableBorder.all(
                                    color: FortniteTheme.darkCard,
                                    width: 1,
                                  ),
                                  columnWidths: const {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(1),
                                    2: FlexColumnWidth(1),
                                  },
                                  children: [
                                    // Header
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: FortniteTheme.darkCard,
                                      ),
                                      children: [
                                        _buildTableCell(
                                          'Nome',
                                          isHeader: true,
                                          context: context,
                                        ),
                                        _buildTableCell(
                                          'Valor',
                                          isHeader: true,
                                          context: context,
                                        ),
                                        _buildTableCell(
                                          'Raridade',
                                          isHeader: true,
                                          context: context,
                                        ),
                                      ],
                                    ),
                                    // Rows
                                    ...cosmetics.map(
                                      (cosmetic) => TableRow(
                                        children: [
                                          _buildTableCell(
                                            cosmetic.name,
                                            context: context,
                                          ),
                                          _buildTableCell(
                                            cosmetic.price.toStringAsFixed(0),
                                            context: context,
                                          ),
                                          _buildTableCell(
                                            cosmetic.rarity,
                                            context: context,
                                            color: FortniteTheme.getRarityColor(
                                              cosmetic.rarity,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Total
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: FortniteTheme.darkCard,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Gasto:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.monetization_on,
                                            color: FortniteTheme.primaryBlue,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            cosmetics
                                                .fold<double>(
                                                  0,
                                                  (sum, c) => sum + c.price,
                                                )
                                                .toStringAsFixed(0),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color:
                                                      FortniteTheme.primaryBlue,
                                                  fontWeight: FontWeight.bold,
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
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTableCell(
    String text, {
    bool isHeader = false,
    required BuildContext context,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: isHeader
            ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: FortniteTheme.primaryBlue,
              )
            : Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
