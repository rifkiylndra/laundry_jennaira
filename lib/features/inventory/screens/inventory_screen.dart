// lib/features/inventory/screens/inventory_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/features/inventory/providers/inventory_provider.dart';
import 'package:laundry_jennaira/shared/models/inventory_model.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryState = ref.watch(inventoryProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: const Text(
          'Manajemen Stok',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: inventoryState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: AppTheme.expenseColor))),
        data: (items) {
          final totalItems = items.length;
          final lowStockItems = items.where((element) => element.stock <= element.minStock).length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Summary Section
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFC4C6D0).withValues(alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'TOTAL ITEM',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$totalItems',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFC4C6D0).withValues(alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'STOK RENDAH',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$lowStockItems',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.expenseColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Inventory List
                ...items.map((item) => _buildInventoryCard(context, ref, item)),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showUpdateStockDialog(BuildContext context, WidgetRef ref, InventoryModel item) {
    final TextEditingController stockController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Update Stok ${item.name}',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Stok Saat Ini: ${item.stock.toStringAsFixed(1)} ${item.unit}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: stockController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: AppTheme.textPrimaryColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Masukkan jumlah...',
                  labelText: 'Penyesuaian (${item.unit})',
                  labelStyle: const TextStyle(color: AppTheme.textSecondaryColor),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.accentColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        final inputValue = double.tryParse(stockController.text.replaceAll(',', '.')) ?? 0.0;
                        double newTotal = item.stock - inputValue;
                        if (newTotal < 0) newTotal = 0;
                        ref.read(inventoryProvider.notifier).updateStock(item, newTotal);
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(backgroundColor: AppTheme.expenseColor),
                      child: const Text('Dipakai (-)'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        final inputValue = double.tryParse(stockController.text.replaceAll(',', '.')) ?? 0.0;
                        final newTotal = item.stock + inputValue;
                        ref.read(inventoryProvider.notifier).updateStock(item, newTotal);
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(backgroundColor: AppTheme.incomeColor),
                      child: const Text('Restok (+)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal', style: TextStyle(color: AppTheme.textSecondaryColor)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInventoryCard(BuildContext context, WidgetRef ref, InventoryModel item) {
    final isLowStock = item.stock <= item.minStock;
    final borderColor = isLowStock ? AppTheme.expenseColor : const Color(0xFFC4C6D0).withValues(alpha: 0.2);
    final borderWidth = isLowStock ? 2.0 : 1.0;

    double ratio = item.stock / (item.minStock * 3);
    if (ratio > 1.0) ratio = 1.0;
    if (ratio < 0.0) ratio = 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showUpdateStockDialog(context, ref, item),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimaryColor,
                              ),
                            ),
                            if (isLowStock) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFDAD6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'STOK RENDAH',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.expenseColor,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Sisa ${item.stock.toStringAsFixed(1)}${item.unit}',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: isLowStock ? FontWeight.w500 : FontWeight.normal,
                            color: isLowStock ? AppTheme.expenseColor : AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.edit, color: AppTheme.textSecondaryColor, size: 20),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFECEEF0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: ratio,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isLowStock ? AppTheme.expenseColor : AppTheme.accentColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              if (isLowStock) ...[
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.warning, color: AppTheme.expenseColor, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Segera restok ulang',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.expenseColor,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
