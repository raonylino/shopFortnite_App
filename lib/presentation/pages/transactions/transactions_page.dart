import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';
import 'package:fortnite_flutter/presentation/cubits/transactions/transactions_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/transactions/transactions_state.dart';
import 'package:fortnite_flutter/presentation/widgets/custom_app_bar.dart';
import 'package:fortnite_flutter/presentation/widgets/loading_widget.dart';
import 'package:intl/intl.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionsCubit>().loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'HISTÓRICO', showBackButton: false),
      body: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          if (state is TransactionsLoading) {
            return const LoadingIndicator(message: 'Carregando transações...');
          }

          if (state is TransactionsError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<TransactionsCubit>().refresh(),
            );
          }

          if (state is TransactionsLoaded) {
            if (state.transactions.isEmpty) {
              return const EmptyStateWidget(
                message: 'Nenhuma transação encontrada',
                icon: Icons.receipt_long_outlined,
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<TransactionsCubit>().refresh();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = state.transactions[index];
                  final isPurchase = transaction.isPurchase;
                  final isReturn = transaction.isReturn;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: FortniteTheme.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isPurchase
                            ? Colors.red.withAlpha(100)
                            : isReturn
                            ? Colors.green.withAlpha(100)
                            : FortniteTheme.darkCard,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isPurchase
                              ? Colors.red.withAlpha(25)
                              : isReturn
                              ? Colors.green.withAlpha(25)
                              : Colors.transparent,
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isPurchase
                              ? Colors.red.withAlpha(50)
                              : isReturn
                              ? Colors.green.withAlpha(50)
                              : FortniteTheme.darkCard,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isPurchase
                              ? Icons.shopping_cart
                              : isReturn
                              ? Icons.assignment_return
                              : Icons.swap_horiz,
                          color: isPurchase
                              ? Colors.red
                              : isReturn
                              ? Colors.green
                              : FortniteTheme.textSecondary,
                          size: 24,
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              transaction.cosmeticName ?? 'Cosmético',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isPurchase
                                  ? Colors.red.withAlpha(50)
                                  : isReturn
                                  ? Colors.green.withAlpha(50)
                                  : FortniteTheme.darkCard,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              isPurchase
                                  ? 'COMPRA'
                                  : isReturn
                                  ? 'DEVOLUÇÃO'
                                  : transaction.type.toUpperCase(),
                              style: TextStyle(
                                color: isPurchase
                                    ? Colors.red
                                    : isReturn
                                    ? Colors.green
                                    : FortniteTheme.textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          if (transaction.cosmeticRarity != null)
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: FortniteTheme.getRarityColor(
                                      transaction.cosmeticRarity!,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  transaction.cosmeticRarity!,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: FortniteTheme.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: FortniteTheme.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                DateFormat(
                                  'dd/MM/yyyy - HH:mm',
                                ).format(transaction.date),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: FortniteTheme.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: isPurchase
                                    ? Colors.red
                                    : isReturn
                                    ? Colors.green
                                    : FortniteTheme.primaryBlue,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${isPurchase ? '-' : '+'}${transaction.amount.abs().toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: isPurchase
                                          ? Colors.red
                                          : isReturn
                                          ? Colors.green
                                          : FortniteTheme.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
}
