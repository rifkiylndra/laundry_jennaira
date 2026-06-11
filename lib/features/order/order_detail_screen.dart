// lib/features/order/order_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/features/order/order_provider.dart';
import 'package:laundry_jennaira/features/order/widgets/payment_bottomsheet.dart';
import 'package:laundry_jennaira/shared/models/order_model.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';
import 'package:laundry_jennaira/core/helpers/printer_helper.dart';
import 'package:laundry_jennaira/core/helpers/wa_helper.dart';

class OrderDetailScreen extends ConsumerWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  int _getCurrentStepIndex(String status, String serviceType) {
    status = status.toLowerCase();
    serviceType = serviceType.toLowerCase();

    if (status == 'diterima') return 0;
    if (status == 'selesai') return 99;

    if (serviceType == 'cuci kering') {
      if (status == 'dicuci') return 1;
      if (status.contains('siap')) return 2;
    } else if (serviceType == 'satuan') {
      if (status == 'diproses' || status == 'dicuci' || status == 'setrika' || status == 'processing') return 1;
      if (status.contains('siap')) return 2;
    } else {
      // Cuci Gosok & Default
      if (status == 'dicuci') return 1;
      if (status == 'setrika') return 2;
      if (status.contains('siap')) return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentStep = _getCurrentStepIndex(order.status, order.service);
    final int finalPrice = (order.price - order.discount).clamp(0, double.infinity).toInt();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Detail Order',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Receipt Card
            _buildReceiptCard(finalPrice),
            const SizedBox(height: 16),
            
            // Status Stepper Card
            _buildStatusCard(currentStep),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(context, ref, finalPrice),
    );
  }

  Widget _buildReceiptCard(int finalPrice) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NO. INVOICE',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order.orderNo,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order.service.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pelanggan',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order.custName ?? 'Tanpa Nama',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            order.custPhone ?? '-',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Berat / Qty',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order.service.toLowerCase() == 'satuan' 
                              ? '${order.weightKg.toInt()} Item'
                              : '${order.weightKg} kg',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Divider
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(color: Color(0xFFE2E8F0), thickness: 1, height: 1),
          ),
          
          // Notes
          if (order.notes != null && order.notes!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.notes, size: 16, color: AppTheme.expenseColor),
                        SizedBox(width: 8),
                        Text(
                          'Catatan Khusus',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.expenseColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '"${order.notes}"',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
          // Total
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Bayar',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (order.discount > 0)
                      Text(
                        formatRupiah(order.price),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          color: AppTheme.expenseColor,
                        ),
                      ),
                    Text(
                      formatRupiah(finalPrice),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(int currentStep) {
    final String serviceType = order.service.toLowerCase();
    
    List<Map<String, dynamic>> steps;
    if (serviceType == 'cuci kering') {
      steps = [
        {'title': 'Antrean', 'subtitle': 'Pesanan telah diterima kasir', 'icon': Icons.check_circle},
        {'title': 'Dicuci', 'subtitle': 'Sedang dalam proses pencucian', 'icon': Icons.local_laundry_service},
        {'title': 'Siap Diambil', 'subtitle': 'Menunggu diambil oleh pelanggan', 'icon': Icons.inventory_2},
      ];
    } else if (serviceType == 'satuan') {
      steps = [
        {'title': 'Antrean', 'subtitle': 'Pesanan telah diterima kasir', 'icon': Icons.check_circle},
        {'title': 'Diproses', 'subtitle': 'Sedang diproses', 'icon': Icons.cleaning_services},
        {'title': 'Siap Diambil', 'subtitle': 'Menunggu diambil oleh pelanggan', 'icon': Icons.inventory_2},
      ];
    } else {
      steps = [
        {'title': 'Antrean', 'subtitle': 'Pesanan telah diterima kasir', 'icon': Icons.check_circle},
        {'title': 'Dicuci', 'subtitle': 'Sedang dalam proses pencucian', 'icon': Icons.local_laundry_service},
        {'title': 'Setrika', 'subtitle': 'Sedang disetrika dan dirapikan', 'icon': Icons.iron},
        {'title': 'Siap Diambil', 'subtitle': 'Menunggu diambil oleh pelanggan', 'icon': Icons.inventory_2},
      ];
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status Pengerjaan',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(steps.length, (index) {
            return _buildTimelineStep(
              title: steps[index]['title'],
              subtitle: steps[index]['subtitle'],
              icon: steps[index]['icon'],
              isActive: currentStep >= index,
              isLast: index == steps.length - 1,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
    required bool isLast,
  }) {
    final color = isActive ? AppTheme.incomeColor : const Color(0xFFCBD5E1);
    
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isActive ? color.withValues(alpha: 0.1) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? Colors.transparent : color,
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: isActive ? color : color,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isActive ? AppTheme.textPrimaryColor : AppTheme.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, WidgetRef ref, int finalPrice) {
    // Check if Bayar Lunas button should be visible
    final bool canPay = !order.isPaid && 
        (order.status.toLowerCase() == 'siap_diambil' || 
         order.status.toLowerCase() == 'siap diambil' || 
         order.status.toLowerCase() == 'selesai');

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Print Struk
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () async {
                  try {
                    await PrinterHelper.printReceipt(order);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString()), backgroundColor: AppTheme.expenseColor),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.print, color: AppTheme.primaryColor),
                label: const Text(
                  'Print Struk',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Kirim Nota via WA
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () async {
                  try {
                    await WaHelper.sendCustomerReceipt(order.custPhone ?? '', order);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString()), backgroundColor: AppTheme.expenseColor),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.send, color: AppTheme.incomeColor), // WA-like color
                label: const Text(
                  'Kirim Nota via WA',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.incomeColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.incomeColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            
            if (canPay) ...[
              const SizedBox(height: 12),
              // Conditionally visible: Bayar Lunas
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => PaymentBottomSheet(order: order),
                    );
                  },
                  icon: const Icon(Icons.payments_outlined),
                  label: const Text(
                    'Bayar Lunas',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
            
            // Logika Update Status
            Builder(
              builder: (context) {
                String nextLabel = '';
                String nextVal = '';
                switch (order.status.toLowerCase()) {
                  case 'diterima':
                    if (order.service.toLowerCase() == 'satuan') {
                      nextLabel = 'Update ke Diproses';
                      nextVal = 'diproses';
                    } else {
                      nextLabel = 'Update ke Dicuci';
                      nextVal = 'dicuci';
                    }
                    break;
                  case 'dicuci':
                  case 'diproses':
                    if (order.service.toLowerCase() == 'cuci kering' || order.service.toLowerCase() == 'satuan') {
                      nextLabel = 'Update ke Siap Diambil';
                      nextVal = 'siap_diambil';
                    } else {
                      nextLabel = 'Update ke Setrika';
                      nextVal = 'setrika';
                    }
                    break;
                  case 'setrika':
                    nextLabel = 'Update ke Siap Diambil';
                    nextVal = 'siap_diambil';
                    break;
                  case 'siap_diambil':
                  case 'siap diambil':
                    nextLabel = 'Update ke Selesai';
                    nextVal = 'selesai';
                    break;
                }

                if (nextLabel.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton.icon(
                        onPressed: () async {
                          final updatedOrder = order.copyWith(status: nextVal);
                          try {
                            await ref.read(orderNotifierProvider.notifier).updateOrder(updatedOrder);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Status diupdate menjadi $nextLabel'),
                                  backgroundColor: AppTheme.incomeColor,
                                ),
                              );
                              Navigator.pop(context); // Kembali ke list agar state terefresh
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
                        label: Text(
                          nextLabel,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
