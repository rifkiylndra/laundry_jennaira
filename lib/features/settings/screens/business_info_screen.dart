import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/features/settings/providers/business_info_provider.dart';

class BusinessInfoScreen extends ConsumerStatefulWidget {
  const BusinessInfoScreen({super.key});

  @override
  ConsumerState<BusinessInfoScreen> createState() => _BusinessInfoScreenState();
}

class _BusinessInfoScreenState extends ConsumerState<BusinessInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _footerController;
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _footerController = TextEditingController();
    
    // We expect the provider to be loaded already since it's used elsewhere, but we handle it just in case.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final infoState = ref.read(businessInfoNotifierProvider);
      if (infoState.value != null) {
        _nameController.text = infoState.value!.name;
        _addressController.text = infoState.value!.address;
        _phoneController.text = infoState.value!.phone;
        _footerController.text = infoState.value!.footerMessage;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _footerController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final newInfo = BusinessInfo(
      name: _nameController.text,
      address: _addressController.text,
      phone: _phoneController.text,
      footerMessage: _footerController.text,
    );

    await ref.read(businessInfoNotifierProvider.notifier).updateInfo(newInfo);

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Info Usaha berhasil diperbarui!'),
          backgroundColor: AppTheme.incomeColor,
        ),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          color: AppTheme.textPrimaryColor,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Inter',
            color: AppTheme.textSecondaryColor,
          ),
          prefixIcon: Icon(icon, color: AppTheme.textSecondaryColor),
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
          if (value == null || value.trim().isEmpty) {
            return '$label wajib diisi';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final infoState = ref.watch(businessInfoNotifierProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Info Usaha', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: infoState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (info) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Pengaturan Usaha',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Informasi ini akan ditampilkan pada struk digital, laporan WhatsApp, dan struk yang dicetak.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nama Usaha',
                    icon: Icons.storefront,
                  ),
                  
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Nomor WhatsApp Admin',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  
                  _buildTextField(
                    controller: _addressController,
                    label: 'Alamat Usaha',
                    icon: Icons.location_on_outlined,
                    maxLines: 3,
                  ),
                  
                  _buildTextField(
                    controller: _footerController,
                    label: 'Pesan Penutup (Footer)',
                    icon: Icons.notes,
                    maxLines: 2,
                  ),
                  
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: _isLoading ? null : _handleSave,
                      icon: _isLoading 
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Icon(Icons.save),
                      label: Text(
                        _isLoading ? 'Menyimpan...' : 'Simpan Info Usaha',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
