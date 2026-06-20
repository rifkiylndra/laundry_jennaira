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

  String _serviceType = 'Cuci Gosok'; // Cuci Kering, Cuci Gosok, Satuan
  String _duration = '3 Hari'; // 3 Hari, 2 Hari, 1 Hari, Express (6-8 Jam)
  String _selectedItem = 'Sprei Kecil (Single)';

  final List<String> _items = PricingEngine.satuanItems;

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
    // Add listeners to text controllers to recalculate price on typing
    _weightController.addListener(_calculateEstimasi);
    _qtyController.addListener(_calculateEstimasi);
  }

  @override
  void dispose() {
    _weightController.removeListener(_calculateEstimasi);
    _qtyController.removeListener(_calculateEstimasi);
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _weightController.dispose();
    _qtyController.dispose();
    _finalPriceController.dispose();
    super.dispose();
  }

  void _calculateEstimasi() {
    double weight = double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 0.0;
    int qty = int.tryParse(_qtyController.text) ?? 0;

    final calculation = PricingEngine.calculatePrice(
      rates: ref.read(pricingProvider),
      serviceType: _serviceType,
      weightKg: weight,
      duration: _duration,
      selectedItem: _selectedItem,
      quantity: qty,
    );

    setState(() {
      _totalPrice = calculation.totalPrice;
      _discountAmount = calculation.discountAmount;
      int finalPrice = _totalPrice - _discountAmount;
      if (finalPrice < 0) finalPrice = 0;
      _finalPriceController.text = finalPrice.toString();
    });
  }

  void _handleSimpan() async {
    if (_formKey.currentState!.validate()) {
      double weight = double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 0.0;
      int durationVal = 3;
      if (_serviceType == 'Cuci Kering' || _serviceType == 'Cuci Gosok') {
        if (_duration == '3 Hari') durationVal = 3;
        else if (_duration == '2 Hari') durationVal = 2;
        else if (_duration == '1 Hari') durationVal = 1;
        else if (_duration == 'Express (6-8 Jam)') durationVal = 0; // 0 represents express
      } else {
        weight = double.tryParse(_qtyController.text) ?? 1.0;
      }

      final newOrder = OrderModel(
        id: const Uuid().v4(),
        orderNo: 'LJ-${DateFormat('ddMM-HHmmss').format(DateTime.now())}',
        custName: _nameController.text.isEmpty ? 'Tanpa Nama' : _nameController.text,
        custPhone: _phoneController.text,
        custAddress: _addressController.text,
        weightKg: weight,
        service: _serviceType == 'Satuan' ? 'Satuan - $_selectedItem' : _serviceType,
        duration: durationVal,
        status: 'diterima',
        price: (int.tryParse(_finalPriceController.text) ?? 0) + _discountAmount,
        discount: _discountAmount,
        isPaid: false,
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
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Jenis Layanan',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildChoiceChip('Cuci Gosok', _serviceType == 'Cuci Gosok', () {
                          setState(() {
                            _serviceType = 'Cuci Gosok';
                            _calculateEstimasi();
                          });
                        }),
                        _buildChoiceChip('Cuci Kering', _serviceType == 'Cuci Kering', () {
                          setState(() {
                            _serviceType = 'Cuci Kering';
                            _calculateEstimasi();
                          });
                        }),
                        _buildChoiceChip('Satuan', _serviceType == 'Satuan', () {
                          setState(() {
                            _serviceType = 'Satuan';
                            _calculateEstimasi();
                          });
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),

                    if (_serviceType == 'Cuci Kering' || _serviceType == 'Cuci Gosok') ...[
                      _buildTextField(
                        controller: _weightController,
                        label: 'Berat (kg)',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        suffixText: 'kg',
                        validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Durasi Layanan',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildChoiceChip('3 Hari', _duration == '3 Hari', () {
                            setState(() {
                              _duration = '3 Hari';
                              _calculateEstimasi();
                            });
                          }),
                          _buildChoiceChip('2 Hari', _duration == '2 Hari', () {
                            setState(() {
                              _duration = '2 Hari';
                              _calculateEstimasi();
                            });
                          }),
                          _buildChoiceChip('1 Hari', _duration == '1 Hari', () {
                            setState(() {
                              _duration = '1 Hari';
                              _calculateEstimasi();
                            });
                          }),
                          _buildChoiceChip('Express (6-8 Jam)', _duration == 'Express (6-8 Jam)', () {
                            setState(() {
                              _duration = 'Express (6-8 Jam)';
                              _calculateEstimasi();
                            });
                          }),
                        ],
                      ),
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DropdownButtonFormField<String>(
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
                                _calculateEstimasi();
                              });
                            }
                          },
                        ),
                      ),
                      _buildTextField(
                        controller: _qtyController,
                        label: 'Jumlah Item',
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
                      ),
                    ],
                    
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
