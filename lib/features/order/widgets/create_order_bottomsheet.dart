// lib/features/order/widgets/create_order_bottomsheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/shared/utils/pricing_engine.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';
import 'package:laundry_jennaira/features/order/order_provider.dart';
import 'package:laundry_jennaira/shared/models/order_model.dart';
import 'package:uuid/uuid.dart';
import 'package:laundry_jennaira/features/settings/providers/pricing_provider.dart';

class CreateOrderBottomSheet extends ConsumerStatefulWidget {
  final String? initialServiceType;
  final String? initialDuration;

  const CreateOrderBottomSheet({
    super.key,
    this.initialServiceType,
    this.initialDuration,
  });

  @override
  ConsumerState<CreateOrderBottomSheet> createState() => _CreateOrderBottomSheetState();
}

class _CreateOrderBottomSheetState extends ConsumerState<CreateOrderBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _weightController = TextEditingController();
  final _qtyController = TextEditingController();
  final _finalPriceController = TextEditingController();

  String _serviceType = 'Cuci Gosok'; // Cuci Kering, Cuci Gosok, Setrika, Satuan
  String _duration = '3 Hari'; // 3 Hari, 2 Hari, 1 Hari, Express (6-8 Jam)
  String _selectedItem = 'Sprei Kecil (Single)';

  final List<String> _items = PricingEngine.satuanItems;
  final List<OrderItem> _cartItems = [];

  int _totalPrice = 0;
  int _discountAmount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialServiceType != null) {
      _serviceType = widget.initialServiceType!;
    }
    if (widget.initialDuration != null) {
      _duration = widget.initialDuration!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _weightController.dispose();
    _qtyController.dispose();
    _finalPriceController.dispose();
    super.dispose();
  }

  void _updateCartPrices() {
    final rates = ref.read(pricingProvider);
    int durationVal = 3;
    if (_duration == '3 Hari') {
      durationVal = 3;
    } else if (_duration == '2 Hari') {
      durationVal = 2;
    } else if (_duration == '1 Hari') {
      durationVal = 1;
    } else if (_duration == 'Express (6-8 Jam)') {
      durationVal = 0;
    }

    final List<OrderItem> updatedItems = [];
    for (var item in _cartItems) {
      final itemCalc = PricingEngine.calculatePrice(
        rates: rates,
        items: [
          OrderItem(
            serviceName: item.serviceName,
            weightOrQty: item.weightOrQty,
            price: 0.0,
          )
        ],
        durationDays: durationVal,
      );
      updatedItems.add(OrderItem(
        serviceName: item.serviceName,
        weightOrQty: item.weightOrQty,
        price: itemCalc.totalPrice.toDouble(),
      ));
    }

    setState(() {
      _cartItems.clear();
      _cartItems.addAll(updatedItems);
      
      // Calculate grand total and discount for the whole cart
      final grandCalc = PricingEngine.calculatePrice(
        rates: rates,
        items: _cartItems,
        durationDays: durationVal,
      );
      _totalPrice = grandCalc.totalPrice;
      _discountAmount = grandCalc.discountAmount;
      
      int finalPrice = _totalPrice - _discountAmount;
      if (finalPrice < 0) finalPrice = 0;
      _finalPriceController.text = finalPrice.toString();
    });
  }

  void _addItemToCart() {
    double weightOrQty = 0.0;
    String name = '';
    
    if (_serviceType == 'Cuci Kering' || _serviceType == 'Cuci Gosok' || _serviceType == 'Setrika') {
      final text = _weightController.text.replaceAll(',', '.');
      final val = double.tryParse(text);
      if (val == null || val <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap masukkan berat yang valid'),
            backgroundColor: AppTheme.expenseColor,
          ),
        );
        return;
      }
      weightOrQty = val;
      name = _serviceType;
      _weightController.clear();
    } else {
      final val = int.tryParse(_qtyController.text);
      if (val == null || val <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap masukkan jumlah item yang valid'),
            backgroundColor: AppTheme.expenseColor,
          ),
        );
        return;
      }
      weightOrQty = val.toDouble();
      name = 'Satuan - $_selectedItem';
      _qtyController.clear();
    }

    final existingIndex = _cartItems.indexWhere((item) => item.serviceName == name);
    if (existingIndex != -1) {
      final existing = _cartItems[existingIndex];
      _cartItems[existingIndex] = OrderItem(
        serviceName: name,
        weightOrQty: existing.weightOrQty + weightOrQty,
        price: 0.0,
      );
    } else {
      _cartItems.add(OrderItem(
        serviceName: name,
        weightOrQty: weightOrQty,
        price: 0.0,
      ));
    }

    // Hide keyboard after adding
    FocusScope.of(context).unfocus();

    _updateCartPrices();
  }

  void _removeItemFromCart(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    _updateCartPrices();
  }

  void _handleSimpan() async {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap tambahkan minimal satu layanan ke dalam list!'),
          backgroundColor: AppTheme.expenseColor,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      int durationVal = 3;
      if (_duration == '3 Hari') {
        durationVal = 3;
      } else if (_duration == '2 Hari') {
        durationVal = 2;
      } else if (_duration == '1 Hari') {
        durationVal = 1;
      } else if (_duration == 'Express (6-8 Jam)') {
        durationVal = 0;
      }

      final newOrder = OrderModel(
        id: const Uuid().v4(),
        orderNo: 'LJ-${DateFormat('ddMM-HHmmss').format(DateTime.now())}',
        custName: _nameController.text.isEmpty ? 'Tanpa Nama' : _nameController.text,
        custPhone: _phoneController.text,
        custAddress: _addressController.text,
        items: List.from(_cartItems),
        durationDays: durationVal,
        status: 'diterima',
        price: (int.tryParse(_finalPriceController.text) ?? 0) + _discountAmount,
        discount: _discountAmount,
        isPaid: false,
        createdAt: DateTime.now(),
      );

      try {
        await ref.read(orderNotifierProvider.notifier).createOrder(newOrder);
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pesanan berhasil dibuat!'),
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
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? suffixText,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 15,
          color: AppTheme.textPrimaryColor,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Inter',
            color: AppTheme.textSecondaryColor,
          ),
          suffixText: suffixText,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF64748B), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.accentColor, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.expenseColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.expenseColor, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool isSelected, VoidCallback onSelect) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelect(),
      selectedColor: AppTheme.accentColor,
      labelStyle: TextStyle(
        fontFamily: 'Inter',
        color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppTheme.accentColor : const Color(0xFFCBD5E1),
        ),
      ),
    );
  }

  Widget _buildCartItem(OrderItem item, int index) {
    final isSatuan = item.serviceName != 'Cuci Gosok' &&
                     item.serviceName != 'Cuci Kering' &&
                     item.serviceName != 'Setrika';
    final unit = isSatuan ? 'Item' : 'kg';
    final weightOrQtyFormatted = isSatuan ? item.weightOrQty.toInt().toString() : item.weightOrQty.toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.serviceName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$weightOrQtyFormatted $unit',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatRupiah(item.price.round()),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppTheme.expenseColor, size: 20),
            onPressed: () => _removeItemFromCart(index),
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentRates = ref.watch(pricingProvider);
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    int finalPrice = _totalPrice - _discountAmount;
    if (finalPrice < 0) finalPrice = 0;
    
    return Container(
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
                'Order Baru',
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
          const SizedBox(height: 16),
          
          // Scrollable Form
          Flexible(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      controller: _nameController,
                      label: 'Nama Pelanggan',
                      validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Nomor Telepon',
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    _buildTextField(
                      controller: _addressController,
                      label: 'Alamat Pelanggan',
                    ),
                    
                    const Divider(color: Color(0xFFE2E8F0), thickness: 1.5, height: 32),
                    
                    // Service Selector Section
                    const Text(
                      'Tambah Layanan',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildChoiceChip('Cuci Gosok', _serviceType == 'Cuci Gosok', () {
                          setState(() {
                            _serviceType = 'Cuci Gosok';
                          });
                        }),
                        _buildChoiceChip('Cuci Kering', _serviceType == 'Cuci Kering', () {
                          setState(() {
                            _serviceType = 'Cuci Kering';
                          });
                        }),
                        _buildChoiceChip('Setrika', _serviceType == 'Setrika', () {
                          setState(() {
                            _serviceType = 'Setrika';
                          });
                        }),
                        _buildChoiceChip('Satuan', _serviceType == 'Satuan', () {
                          setState(() {
                            _serviceType = 'Satuan';
                          });
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),

                    if (_serviceType == 'Cuci Kering' || _serviceType == 'Cuci Gosok' || _serviceType == 'Setrika') ...[
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _weightController,
                              label: 'Berat (kg)',
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              suffixText: 'kg',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: SizedBox(
                              height: 52,
                              child: FilledButton.icon(
                                onPressed: _addItemToCart,
                                icon: const Icon(Icons.add, size: 20),
                                label: const Text('Tambah', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold)),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppTheme.accentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      DropdownButtonFormField<String>(
                        value: _selectedItem,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: 'Pilih Item',
                          labelStyle: const TextStyle(
                            fontFamily: 'Inter',
                            color: AppTheme.textSecondaryColor,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF64748B), width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppTheme.accentColor, width: 1.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        items: _items.map((item) {
                          final price = PricingEngine.getSatuanPrice(item, currentRates);
                          return DropdownMenuItem(
                            value: item,
                            child: Text('$item (${formatRupiah(price)})', style: const TextStyle(fontFamily: 'Inter', fontSize: 14)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedItem = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _qtyController,
                              label: 'Jumlah Item',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: SizedBox(
                              height: 52,
                              child: FilledButton.icon(
                                onPressed: _addItemToCart,
                                icon: const Icon(Icons.add, size: 20),
                                label: const Text('Tambah', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold)),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppTheme.accentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const Divider(color: Color(0xFFE2E8F0), thickness: 1.5, height: 32),

                    // Added items list
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daftar Layanan',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                        Text(
                          '(${_cartItems.length} Layanan)',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    if (_cartItems.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.shopping_cart_outlined, size: 36, color: AppTheme.textSecondaryColor),
                            SizedBox(height: 8),
                            Text(
                              'Belum ada layanan ditambahkan',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ...List.generate(_cartItems.length, (index) => _buildCartItem(_cartItems[index], index)),

                    const Divider(color: Color(0xFFE2E8F0), thickness: 1.5, height: 32),

                    // Duration selector section
                    const Text(
                      'Durasi Layanan',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildChoiceChip('3 Hari', _duration == '3 Hari', () {
                          setState(() {
                            _duration = '3 Hari';
                          });
                          _updateCartPrices();
                        }),
                        _buildChoiceChip('2 Hari', _duration == '2 Hari', () {
                          setState(() {
                            _duration = '2 Hari';
                          });
                          _updateCartPrices();
                        }),
                        _buildChoiceChip('1 Hari', _duration == '1 Hari', () {
                          setState(() {
                            _duration = '1 Hari';
                          });
                          _updateCartPrices();
                        }),
                        _buildChoiceChip('Express (6-8 Jam)', _duration == 'Express (6-8 Jam)', () {
                          setState(() {
                            _duration = 'Express (6-8 Jam)';
                          });
                          _updateCartPrices();
                        }),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom Summary & Button
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Estimasi',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    if (_discountAmount > 0)
                      Text(
                        formatRupiah(_totalPrice),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: AppTheme.expenseColor,
                        ),
                      ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 140,
                      child: TextFormField(
                        controller: _finalPriceController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimaryColor,
                        ),
                        decoration: InputDecoration(
                          prefixText: 'Rp ',
                          prefixStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppTheme.accentColor, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: _handleSimpan,
                    icon: const Icon(Icons.save_outlined, size: 20),
                    label: const Text(
                      'Simpan Order',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
