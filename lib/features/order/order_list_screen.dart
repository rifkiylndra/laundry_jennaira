// lib/features/order/order_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/features/auth/auth_provider.dart';
import 'package:laundry_jennaira/features/order/order_provider.dart';
import 'package:laundry_jennaira/shared/models/order_model.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';

class OrderListScreen extends ConsumerStatefulWidget {
  const OrderListScreen({super.key});

  @override
  ConsumerState<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends ConsumerState<OrderListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final profile = authState.valueOrNull;
    final isAdmin = profile?.role == 'admin';

    final ordersAsync = ref.watch(orderNotifierProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          title: const Text(
            'Laundry Jennaira',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            if (isAdmin)
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.push('/settings');
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  ref.read(authProvider.notifier).signOut();
                },
              ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: Container(
              color: AppTheme.backgroundColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari Order...',
                        prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondaryColor),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.accentColor, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  const TabBar(
                    indicatorColor: AppTheme.accentColor,
                    indicatorWeight: 3,
                    labelColor: AppTheme.accentColor,
                    unselectedLabelColor: AppTheme.textSecondaryColor,
                    labelStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    tabs: [
                      Tab(text: 'Aktif'),
                      Tab(text: 'Selesai'),
                      Tab(text: 'Belum Lunas'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ordersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: AppTheme.accentColor)),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Terjadi kesalahan:\n${error.toString()}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.expenseColor),
              ),
            ),
          ),
          data: (orders) {
            // Apply search filter
            var filteredOrders = orders.where((order) {
              final searchMatch = order.orderNo.toLowerCase().contains(_searchQuery) ||
                  (order.custName?.toLowerCase().contains(_searchQuery) ?? false);
              return searchMatch;
            }).toList();

            // Split into tabs
            final activeOrders = filteredOrders.where((o) => o.status != 'selesai' && o.status != 'batal').toList();
            final completedOrders = filteredOrders.where((o) => o.status == 'selesai').toList();
            final unpaidOrders = filteredOrders.where((o) => !o.isPaid).toList();

            return TabBarView(
              children: [
                _buildOrderList(activeOrders),
                _buildOrderList(completedOrders),
                _buildOrderList(unpaidOrders),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: Buka BottomSheet Buat Order
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildOrderList(List<OrderModel> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tidak ada pesanan',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppTheme.accentColor,
      onRefresh: () async {
        // ignore: unused_result
        ref.refresh(orderNotifierProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderCard(order: order);
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;

  const _OrderCard({required this.order});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'diterima':
        return AppTheme.accentColor;
      case 'dicuci':
        return AppTheme.primaryColor;
      case 'siap_diambil':
      case 'siap diambil':
        return AppTheme.warningColor;
      case 'selesai':
        return AppTheme.incomeColor;
      default:
        return AppTheme.textSecondaryColor;
    }
  }

  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'diterima':
        return 'Diterima';
      case 'dicuci':
        return 'Proses';
      case 'siap_diambil':
      case 'siap diambil':
        return 'Siap Diambil';
      case 'selesai':
        return 'Selesai';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _formatStatus(order.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: statusColor, width: 4),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // TODO: Navigate to Order Detail
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Order No & Status Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.orderNo,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Customer Name
                    Text(
                      order.custName ?? 'Tanpa Nama',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Bottom Row: Service, Weight, Price, Payment Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Details: Weight & Price
                        Row(
                          children: [
                            const Icon(Icons.shopping_bag_outlined, size: 16, color: AppTheme.textSecondaryColor),
                            const SizedBox(width: 4),
                            Text(
                              '${order.weightKg} kg',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.payments_outlined, size: 16, color: AppTheme.textSecondaryColor),
                            const SizedBox(width: 4),
                            Text(
                              formatRupiah(order.price),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        
                        // Payment Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: order.isPaid 
                                ? AppTheme.incomeColor.withValues(alpha: 0.1) 
                                : AppTheme.expenseColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            order.isPaid ? 'Lunas' : 'Belum Lunas',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: order.isPaid ? AppTheme.incomeColor : AppTheme.expenseColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Service Type (Kiloan/Satuan)
                    Text(
                      'Layanan: ${order.service}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: AppTheme.textSecondaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
