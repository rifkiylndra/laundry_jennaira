// lib/features/order/widgets/payment_bottomsheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/features/order/order_provider.dart';
import 'package:laundry_jennaira/shared/models/order_model.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';
import 'package:laundry_jennaira/features/transaction/transaction_provider.dart';
import 'package:laundry_jennaira/shared/models/transaction_model.dart';
import 'package:laundry_jennaira/core/supabase_client.dart';
import 'package:uuid/uuid.dart';

class PaymentBottomSheet extends ConsumerStatefulWidget {
  final OrderModel order;

  const PaymentBottomSheet({super.key, required this.order});

  @override
  ConsumerState<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends ConsumerState<PaymentBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  
  String _paymentMethod = 'Tunai'; // Tunai, QRIS
  int _amountReceived = 0;
  bool _isLoading = false;

  late final int _finalPrice;

  @override
  void initState() {
    super.initState();
    _finalPrice = (widget.order.price - widget.order.discount).clamp(0, double.infinity).toInt();
    _amountController.addListener(_calculateChange);
  }

  @override
  void dispose() {
    _amountController.removeListener(_calculateChange);
    _amountController.dispose();
    super.dispose();
  }

  void _calculateChange() {
    setState(() {
      _amountReceived = int.tryParse(_amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    });
  }

  Future<void> _handleConfirm() async {
    if (_paymentMethod == 'Tunai') {
      if (!_formKey.currentState!.validate()) return;
      if (_amountReceived < _finalPrice) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Uang diterima tidak boleh kurang dari total tagihan'),
            backgroundColor: AppTheme.expenseColor,
          ),
        );
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      final updatedOrder = widget.order.copyWith(
        isPaid: true,
        status: 'selesai',
      );
      
      final transaction = TransactionModel(
        id: const Uuid().v4(),
        orderId: widget.order.id,
        amount: _finalPrice,
        type: 'income',
        description: 'Pembayaran Pesanan ${widget.order.custName ?? widget.order.orderNo}',
        paymentMethod: _paymentMethod == 'Tunai' ? 'CASH' : 'QRIS',
        createdAt: DateTime.now(),
      );

      await Future.wait([
        ref.read(orderNotifierProvider.notifier).updateOrder(updatedOrder),
        ref.read(transactionNotifierProvider.notifier).addTransaction(transaction),
      ]);

      if (mounted) {
        Navigator.pop(context); // Close BottomSheet
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pembayaran berhasil dikonfirmasi!'),
            backgroundColor: AppTheme.incomeColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().replaceAll('Exception: ', ''),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppTheme.expenseColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final int change = _amountReceived - _finalPrice;

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
        bottom: 24 + keyboardSpace,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Title & Close
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pembayaran',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppTheme.textSecondaryColor),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Total Amount Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  'Total Tagihan',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  formatRupiah(_finalPrice),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Payment Method Segmented Button
          const Text(
            'Metode Pembayaran',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment<String>(
                value: 'Tunai',
                label: Text('Tunai', style: TextStyle(fontFamily: 'Inter')),
                icon: Icon(Icons.payments),
              ),
              ButtonSegment<String>(
                value: 'QRIS',
                label: Text('QRIS', style: TextStyle(fontFamily: 'Inter')),
                icon: Icon(Icons.qr_code_2),
              ),
            ],
            selected: {_paymentMethod},
            onSelectionChanged: (Set<String> newSelection) {
              setState(() {
                _paymentMethod = newSelection.first;
              });
            },
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: AppTheme.accentColor.withValues(alpha: 0.1),
              selectedForegroundColor: AppTheme.accentColor,
            ),
          ),
          const SizedBox(height: 24),

          // Dynamic Content based on Payment Method
          if (_paymentMethod == 'Tunai')
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Uang Diterima',
                      labelStyle: const TextStyle(
                        fontFamily: 'Inter',
                        color: AppTheme.textSecondaryColor,
                      ),
                      prefixText: 'Rp ',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppTheme.accentColor, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppTheme.expenseColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppTheme.expenseColor, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan jumlah uang diterima';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Change (Kembalian) Calculation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kembalian:',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                      Text(
                        change > 0 ? formatRupiah(change) : 'Rp 0',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: change >= 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Scan QRIS di bawah ini:',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Image.network(
                    supabase.storage.from('settings').getPublicUrl('qris/active_qris.png'),
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Column(
                      children: [
                        Icon(Icons.qr_code_scanner, size: 48, color: AppTheme.accentColor),
                        SizedBox(height: 16),
                        Text('Belum ada QRIS yang diatur.', style: TextStyle(color: AppTheme.expenseColor)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Pastikan pembayaran telah berhasil sebelum mengkonfirmasi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
          const SizedBox(height: 32),
          
          // Confirm Button
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: _isLoading ? null : _handleConfirm,
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Konfirmasi Pembayaran',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    ));
  }
}
