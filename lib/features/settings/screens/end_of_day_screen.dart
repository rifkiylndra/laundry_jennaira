// lib/features/settings/screens/end_of_day_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';
import 'package:laundry_jennaira/features/transaction/transaction_provider.dart';
import 'package:laundry_jennaira/core/helpers/wa_helper.dart';

class EndOfDayScreen extends ConsumerWidget {
  const EndOfDayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We assume transactionNotifierProvider is already loaded/watched elsewhere or we just watch it
    ref.watch(transactionNotifierProvider);
    final summary = ref
        .read(transactionNotifierProvider.notifier)
        .getEndOfDaySummary();

    final int totalCash = summary['totalCash'] ?? 0;
    final int totalQris = summary['totalQris'] ?? 0;
    final int totalExpense = summary['totalExpense'] ?? 0;
    final int totalIncome = totalCash + totalQris;
    final int netProfit = totalIncome - totalExpense;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Tutup Buku Harian',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.receipt_long,
              size: 64,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'Rekapitulasi Hari Ini',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Periksa kembali kecocokan uang di laci kasir dengan sistem sebelum melakukan tutup buku.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 32),

            // Summary Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFCBD5E1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSummaryRow(
                    'Pemasukan Tunai',
                    totalCash,
                    AppTheme.textPrimaryColor,
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    'Pemasukan QRIS',
                    totalQris,
                    AppTheme.textPrimaryColor,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: Color(0xFFCBD5E1)),
                  ),
                  _buildSummaryRow(
                    'Total Pemasukan',
                    totalIncome,
                    AppTheme.incomeColor,
                    isBold: true,
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryRow(
                    'Pengeluaran',
                    totalExpense,
                    AppTheme.expenseColor,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: Color(0xFFCBD5E1)),
                  ),
                  _buildSummaryRow(
                    'Total Laba Bersih',
                    netProfit,
                    AppTheme.accentColor,
                    isBold: true,
                    isLarge: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: 56,
            child: FilledButton.icon(
              onPressed: () async {
                // We use a dummy owner number here for demonstration.
                final ownerPhone = '082392240627';
                try {
                  await WaHelper.sendEndOfDayReport(ownerPhone, summary);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Laporan Tutup Buku terkirim!'),
                        backgroundColor: AppTheme.incomeColor,
                      ),
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: AppTheme.expenseColor,
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text(
                'Konfirmasi Tutup Buku',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    int amount,
    Color amountColor, {
    bool isBold = false,
    bool isLarge = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: isLarge ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        Text(
          formatRupiah(amount),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: isLarge ? 20 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: amountColor,
          ),
        ),
      ],
    );
  }
}
