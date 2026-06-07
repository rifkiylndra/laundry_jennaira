// lib/features/transaction/transaction_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';
import 'package:laundry_jennaira/features/transaction/transaction_provider.dart';
import 'package:laundry_jennaira/shared/models/transaction_model.dart';
import 'package:laundry_jennaira/features/transaction/widgets/add_expense_bottomsheet.dart';

class TransactionListScreen extends ConsumerStatefulWidget {
  const TransactionListScreen({super.key});

  @override
  ConsumerState<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends ConsumerState<TransactionListScreen> {
  String _activeFilter = 'Semua';

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Hari Ini';
    } else if (dateOnly == yesterday) {
      return 'Kemarin';
    } else {
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  IconData _getIconForCategory(String? categoryId, bool isIncome) {
    if (categoryId == 'Deterjen') return Icons.local_laundry_service;
    if (categoryId == 'Listrik') return Icons.bolt;
    if (categoryId == 'Sewa') return Icons.home_work;
    if (categoryId == 'Gaji') return Icons.payments;
    if (categoryId == 'Alat Cuci') return Icons.cleaning_services;
    if (categoryId == 'Lain-lain') return Icons.more_horiz;
    return isIncome ? Icons.shopping_basket_outlined : Icons.electric_bolt;
  }

  @override
  Widget build(BuildContext context) {
    final transactionsState = ref.watch(transactionNotifierProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Row(
          children: [
            Icon(Icons.local_laundry_service, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Transaksi',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: transactionsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Terjadi kesalahan: $error', style: const TextStyle(color: AppTheme.expenseColor)),
              ElevatedButton(
                onPressed: () => ref.read(transactionNotifierProvider.notifier).refresh(),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
        data: (transactions) {
          // Calculate Totals based on filter
          int totalIncome = 0;
          int totalExpense = 0;
          
          List<TransactionModel> filteredTransactions = [];

          for (var t in transactions) {
            if (t.type == 'income') {
              totalIncome += t.amount;
            } else if (t.type == 'expense') {
              totalExpense += t.amount;
            }

            if (_activeFilter == 'Semua') {
              filteredTransactions.add(t);
            } else if (_activeFilter == 'Pemasukan' && t.type == 'income') {
              filteredTransactions.add(t);
            } else if (_activeFilter == 'Pengeluaran' && t.type == 'expense') {
              filteredTransactions.add(t);
            }
          }

          int displayedTotal = 0;
          if (_activeFilter == 'Semua') {
            displayedTotal = totalIncome - totalExpense;
          } else if (_activeFilter == 'Pemasukan') {
            displayedTotal = totalIncome;
          } else if (_activeFilter == 'Pengeluaran') {
            displayedTotal = totalExpense;
          }

          // Group by date
          final Map<String, List<TransactionModel>> groupedTransactions = {};
          for (var t in filteredTransactions) {
            final tDate = t.createdAt?.toLocal() ?? DateTime.now();
            final dateKey = _formatDate(tDate);
            if (!groupedTransactions.containsKey(dateKey)) {
              groupedTransactions[dateKey] = [];
            }
            groupedTransactions[dateKey]!.add(t);
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(transactionNotifierProvider.notifier).refresh(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Semua', 'Pemasukan', 'Pengeluaran'].map((filter) {
                      final isSelected = _activeFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(
                            filter,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? Colors.white : AppTheme.textSecondaryColor,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _activeFilter = filter);
                            }
                          },
                          selectedColor: AppTheme.accentColor,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected ? AppTheme.accentColor : const Color(0xFFCBD5E1),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // Total Saldo Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _activeFilter == 'Semua' ? 'TOTAL SALDO' : (_activeFilter == 'Pemasukan' ? 'TOTAL PEMASUKAN' : 'TOTAL PENGELUARAN'),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatRupiah(displayedTotal),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white24,
                        size: 48,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Transaction Groups
                if (filteredTransactions.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'Belum ada transaksi.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ),
                  )
                else
                  ...groupedTransactions.entries.map((entry) {
                    final dateKey = entry.key;
                    final txs = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12, left: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateKey,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...txs.map((t) {
                          final isIncome = t.type == 'income';
                          final tDate = t.createdAt?.toLocal() ?? DateTime.now();

                          String rawDesc = t.description ?? 'Transaksi';
                          String? parsedCategory;
                          String displayDesc = rawDesc;

                          if (rawDesc.startsWith('[')) {
                            final endIndex = rawDesc.indexOf(']');
                            if (endIndex != -1) {
                              parsedCategory = rawDesc.substring(1, endIndex);
                              displayDesc = rawDesc.substring(endIndex + 1).trim();
                            }
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: isIncome 
                                      ? AppTheme.incomeColor.withValues(alpha: 0.1) 
                                      : AppTheme.expenseColor.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getIconForCategory(parsedCategory, isIncome),
                                  color: isIncome ? AppTheme.incomeColor : AppTheme.expenseColor,
                                ),
                              ),
                              title: Text(
                                displayDesc,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  '${t.orderId != null ? 'Order #${t.orderId!.substring(0,4)} • ' : ''}${_formatTime(tDate)}',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${isIncome ? '+' : '-'}${formatRupiah(t.amount)}',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isIncome ? AppTheme.incomeColor : AppTheme.expenseColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isIncome ? 'QRIS' : 'CASH', // Or dynamic if added to model later
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddExpenseBottomSheet(),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
