// lib/features/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';
import 'package:laundry_jennaira/features/dashboard/dashboard_provider.dart';
import 'package:laundry_jennaira/features/order/widgets/create_order_bottomsheet.dart';
import 'package:laundry_jennaira/features/inventory/providers/inventory_provider.dart';
import 'package:laundry_jennaira/features/inventory/screens/inventory_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dashboardStatsProvider);
    final inventoryState = ref.watch(inventoryProvider);
    
    final inventoryItems = inventoryState.valueOrNull ?? [];
    final lowStockItems = inventoryItems.where((item) => item.stock <= item.minStock).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.local_laundry_service, color: AppTheme.primaryColor),
            const SizedBox(width: 12),
            const Text(
              'Laundry Jennaira',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.textPrimaryColor),
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Cards
            Row(
              children: [
                _buildSummaryCard(
                  title: 'Omzet',
                  amount: formatRupiah(stats.todayOmzet),
                  textColor: AppTheme.incomeColor,
                ),
                const SizedBox(width: 12),
                _buildSummaryCard(
                  title: 'Pengeluaran',
                  amount: formatRupiah(stats.todayExpense),
                  textColor: AppTheme.expenseColor,
                ),
                const SizedBox(width: 12),
                _buildSummaryCard(
                  title: 'Profit',
                  amount: formatRupiah(stats.todayProfit),
                  textColor: AppTheme.primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Chart Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '7 Hari Terakhir',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.go('/reports');
                        },
                        child: const Text(
                          'Lihat Detail',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
                                final todayWeekday = DateTime.now().weekday;
                                final dayIndex = (todayWeekday - 1 - (6 - value.toInt())) % 7;
                                final normalizedIndex = dayIndex < 0 ? dayIndex + 7 : dayIndex;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    days[normalizedIndex],
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.textSecondaryColor,
                                    ),
                                  ),
                                );
                              },
                              reservedSize: 24,
                            ),
                          ),
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(7, (index) {
                          return _makeGroupData(index, stats.weeklyChartData[index].toDouble());
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            const Text(
              'Layanan Cepat',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildQuickAction(
                  icon: Icons.dry_cleaning,
                  title: 'Cuci Kering',
                  isPrimary: true,
                  onTap: () => _openCreateOrder(context, serviceType: 'Cuci Kering'),
                ),
                _buildQuickAction(
                  icon: Icons.local_laundry_service,
                  title: 'Cuci Gosok',
                  isPrimary: false,
                  onTap: () => _openCreateOrder(context, serviceType: 'Cuci Gosok'),
                ),
                _buildQuickAction(
                  icon: Icons.iron,
                  title: 'Setrika',
                  isPrimary: false,
                  onTap: () => _openCreateOrder(context, serviceType: 'Setrika'),
                ),
                _buildQuickAction(
                  icon: Icons.checkroom,
                  title: 'Satuan',
                  isPrimary: true,
                  onTap: () => _openCreateOrder(context, serviceType: 'Satuan'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Inventory Warning
            if (lowStockItems.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.expenseColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.expenseColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.warning, color: AppTheme.expenseColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stok ${lowStockItems.first.name} Rendah${lowStockItems.length > 1 ? ' (+${lowStockItems.length - 1} lainnya)' : ''}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          Text(
                            'Sisa ${lowStockItems.first.stock.toStringAsFixed(1)} ${lowStockItems.first.unit}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const InventoryScreen()));
                      },
                      child: const Text(
                        'Isi Ulang',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 100), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String amount,
    required Color textColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                amount,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppTheme.accentColor,
          width: 20,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String title,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? AppTheme.primaryColor : Colors.white,
        border: isPrimary ? null : Border.all(color: AppTheme.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? Colors.white : AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isPrimary ? Colors.white : AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCreateOrder(BuildContext context, {String? serviceType, String? duration}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateOrderBottomSheet(
        initialServiceType: serviceType,
        initialDuration: duration,
      ),
    );
  }
}
