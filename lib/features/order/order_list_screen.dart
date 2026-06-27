// lib/features/order/order_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/features/auth/auth_provider.dart';
import 'package:laundry_jennaira/features/order/order_provider.dart';
import 'package:laundry_jennaira/features/order/widgets/create_order_bottomsheet.dart';
import 'package:laundry_jennaira/features/order/order_detail_screen.dart';
import 'package:laundry_jennaira/shared/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';

class OrderListScreen extends ConsumerStatefulWidget {
  const OrderListScreen({super.key});

  @override
  ConsumerState<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends ConsumerState<OrderListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  DateTime? _selectedFilterDate;
  String? _selectedFilterService;

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
            preferredSize: const Size.fromHeight(180),
            child: Container(
              color: AppTheme.backgroundColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                    child: Row(
                      children: [
                        // Date Filter Button
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _selectedFilterDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: AppTheme.primaryColor,
                                        onPrimary: Colors.white,
                                        onSurface: AppTheme.textPrimaryColor,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (date != null) {
                                setState(() => _selectedFilterDate = date);
                              }
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: _selectedFilterDate != null ? AppTheme.accentColor.withValues(alpha: 0.1) : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.accentColor.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today, size: 14, color: _selectedFilterDate != null ? AppTheme.accentColor : AppTheme.textSecondaryColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    _selectedFilterDate != null ? DateFormat('dd MMM yyyy').format(_selectedFilterDate!) : 'Tanggal',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _selectedFilterDate != null ? AppTheme.accentColor : AppTheme.textSecondaryColor,
                                    ),
                                  ),
                                  if (_selectedFilterDate != null) ...[
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () => setState(() => _selectedFilterDate = null),
                                      child: const Icon(Icons.close, size: 16, color: AppTheme.expenseColor),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Service Filter Dropdown/Button
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                builder: (ctx) {
                                  final services = ['Semua', 'Cuci Gosok', 'Cuci Kering', 'Setrika', 'Satuan'];
                                  return SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Pilih Layanan',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          ...services.map((s) => ListTile(
                                            title: Text(
                                              s,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: _selectedFilterService == s || (_selectedFilterService == null && s == 'Semua') ? FontWeight.bold : FontWeight.normal,
                                                color: _selectedFilterService == s || (_selectedFilterService == null && s == 'Semua') ? AppTheme.primaryColor : AppTheme.textPrimaryColor,
                                              ),
                                            ),
                                            trailing: _selectedFilterService == s || (_selectedFilterService == null && s == 'Semua') 
                                                ? const Icon(Icons.check, color: AppTheme.primaryColor) 
                                                : null,
                                            onTap: () {
                                              setState(() => _selectedFilterService = s == 'Semua' ? null : s);
                                              Navigator.pop(ctx);
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: _selectedFilterService != null ? AppTheme.accentColor.withValues(alpha: 0.1) : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.accentColor.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.local_laundry_service, size: 14, color: _selectedFilterService != null ? AppTheme.accentColor : AppTheme.textSecondaryColor),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _selectedFilterService ?? 'Layanan',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedFilterService != null ? AppTheme.accentColor : AppTheme.textSecondaryColor,
                                      ),
                                    ),
                                  ),
                                  if (_selectedFilterService != null) ...[
                                    GestureDetector(
                                      onTap: () => setState(() => _selectedFilterService = null),
                                      child: const Icon(Icons.close, size: 16, color: AppTheme.expenseColor),
                                    ),
                                  ] else ...[
                                    const Icon(Icons.arrow_drop_down, size: 16, color: AppTheme.textSecondaryColor),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
            // Apply search and advanced filters
            var filteredOrders = orders.where((order) {
              final searchMatch = order.orderNo.toLowerCase().contains(_searchQuery) ||
                  (order.custName?.toLowerCase().contains(_searchQuery) ?? false);
              
              bool dateMatch = true;
              if (_selectedFilterDate != null) {
                final oDate = (order.createdAt ?? DateTime.now()).toLocal();
                dateMatch = oDate.year == _selectedFilterDate!.year && 
                            oDate.month == _selectedFilterDate!.month && 
                            oDate.day == _selectedFilterDate!.day;
              }

              bool serviceMatch = true;
              if (_selectedFilterService != null) {
                if (_selectedFilterService == 'Satuan') {
                  serviceMatch = order.items.any((item) =>
                      item.serviceName != 'Cuci Gosok' &&
                      item.serviceName != 'Cuci Kering' &&
                      item.serviceName != 'Setrika');
                } else {
                  serviceMatch = order.items.any((item) => item.serviceName == _selectedFilterService);
                }
              }

              return searchMatch && dateMatch && serviceMatch;
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
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const CreateOrderBottomSheet(),
            );
          },
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
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
              Icons.receipt_long_rounded,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Belum Ada Data',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Daftar pesanan saat ini masih kosong.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.grey,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(order: order),
                  ),
                );
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
                        // Details: Weight, Price, Duration
                        Expanded(
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.shopping_bag_outlined, size: 16, color: AppTheme.textSecondaryColor),
                                  const SizedBox(width: 4),
                                  Builder(
                                    builder: (context) {
                                      final kiloanItems = order.items.where((e) =>
                                          e.serviceName == 'Cuci Gosok' ||
                                          e.serviceName == 'Cuci Kering' ||
                                          e.serviceName == 'Setrika');
                                      final satuanItems = order.items.where((e) =>
                                          e.serviceName != 'Cuci Gosok' &&
                                          e.serviceName != 'Cuci Kering' &&
                                          e.serviceName != 'Setrika');

                                      String weightOrQtyLabel = '';
                                      if (kiloanItems.isNotEmpty && satuanItems.isNotEmpty) {
                                        final weight = kiloanItems.fold<double>(0.0, (sum, e) => sum + e.weightOrQty);
                                        final qty = satuanItems.fold<double>(0.0, (sum, e) => sum + e.weightOrQty).toInt();
                                        weightOrQtyLabel = '$weight kg + $qty Item';
                                      } else if (kiloanItems.isNotEmpty) {
                                        final weight = kiloanItems.fold<double>(0.0, (sum, e) => sum + e.weightOrQty);
                                        weightOrQtyLabel = '$weight kg';
                                      } else if (satuanItems.isNotEmpty) {
                                        final qty = satuanItems.fold<double>(0.0, (sum, e) => sum + e.weightOrQty).toInt();
                                        weightOrQtyLabel = '$qty Item';
                                      } else {
                                        weightOrQtyLabel = '0 kg';
                                      }

                                      return Text(
                                        weightOrQtyLabel,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 13,
                                          color: AppTheme.textSecondaryColor,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.schedule, size: 16, color: AppTheme.textSecondaryColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${order.durationDays} Hari ${order.remainingDaysText}',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: AppTheme.textSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
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
                      'Layanan: ${order.items.map((e) => e.serviceName).join(", ")}',
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
