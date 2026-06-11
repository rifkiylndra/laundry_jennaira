// lib/features/transaction/widgets/add_expense_bottomsheet.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/features/transaction/transaction_provider.dart';
import 'package:laundry_jennaira/shared/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

class AddExpenseBottomSheet extends ConsumerStatefulWidget {
  const AddExpenseBottomSheet({super.key});

  @override
  ConsumerState<AddExpenseBottomSheet> createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends ConsumerState<AddExpenseBottomSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isLoading = false;
  String _selectedType = 'expense'; // 'income' or 'expense'
  String _selectedCategory = 'Lain-lain';

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Deterjen', 'icon': Icons.local_laundry_service},
    {'name': 'Listrik', 'icon': Icons.bolt},
    {'name': 'Sewa', 'icon': Icons.home_work},
    {'name': 'Gaji', 'icon': Icons.payments},
    {'name': 'Alat Cuci', 'icon': Icons.cleaning_services},
    {'name': 'Lain-lain', 'icon': Icons.more_horiz},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final amountText = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final amount = int.tryParse(amountText) ?? 0;
    final note = _noteController.text.trim();

    if (amount <= 0) {
      _showError('Jumlah transaksi harus diisi');
      return;
    }

    if (note.isEmpty) {
      _showError('Keterangan / Catatan transaksi wajib diisi');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final transaction = TransactionModel(
        id: const Uuid().v4(),
        type: _selectedType,
        amount: amount,
        description: '[$_selectedCategory] $note',
        createdAt: DateTime.now(),
      );

      await ref.read(transactionNotifierProvider.notifier).addTransaction(transaction);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaksi berhasil dicatat!'),
            backgroundColor: AppTheme.incomeColor,
          ),
        );
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.replaceAll('Exception: ', ''),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.expenseColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          top: 12,
          left: 24,
          right: 24,
          bottom: 24 + bottomInsets,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E3E5), // outline-variant/50
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Title
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tambah Transaksi',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              Icon(Icons.local_laundry_service, color: AppTheme.primaryColor), // Logo placeholder
            ],
          ),
          const SizedBox(height: 24),

          // 1. Segmented Control
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F6), // surface-container-low
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedType = 'income'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _selectedType == 'income' ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: _selectedType == 'income'
                            ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Pemasukan',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: _selectedType == 'income' ? FontWeight.bold : FontWeight.w500,
                          color: _selectedType == 'income' ? AppTheme.incomeColor : AppTheme.textSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedType = 'expense'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _selectedType == 'expense' ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: _selectedType == 'expense'
                            ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Pengeluaran',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: _selectedType == 'expense' ? FontWeight.bold : FontWeight.w500,
                          color: _selectedType == 'expense' ? AppTheme.expenseColor : AppTheme.textSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 2. Category Grid
          const Text(
            'KATEGORI',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondaryColor,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = _selectedCategory == cat['name'];
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = cat['name'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFF2F4F6) : Colors.white,
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryColor : const Color(0xFFE0E3E5).withValues(alpha: 0.5),
                      width: isSelected ? 1.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      if (!isSelected)
                        const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        cat['icon'] as IconData,
                        color: AppTheme.primaryColor,
                        size: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cat['name'] as String,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // 3. Numeric Input
          const Center(
            child: Text(
              'Jumlah Transaksi',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Rp',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(width: 8),
              IntrinsicWidth(
                child: TextField(
                  controller: _amountController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                  decoration: const InputDecoration(
                    hintText: '0',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Center(
            child: Container(
              height: 2,
              width: 150,
              color: const Color(0xFFC4C6D0).withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 24),

          // 4. Form Bottom
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              hintText: 'Catatan transaksi...',
              filled: true,
              fillColor: const Color(0xFFF2F4F6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFC4C6D0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFC4C6D0), width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.accentColor, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_a_photo, color: AppTheme.accentColor),
            label: const Text(
              'Upload Foto',
              style: TextStyle(
                fontFamily: 'Inter',
                color: AppTheme.accentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 12),

          FilledButton(
            onPressed: _isLoading ? null : _handleSave,
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text(
                    'Simpan Transaksi',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
    ));
  }
}
