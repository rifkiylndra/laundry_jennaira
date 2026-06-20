import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/features/settings/providers/pricing_provider.dart';

class EditTarifScreen extends ConsumerStatefulWidget {
  const EditTarifScreen({super.key});

  @override
  ConsumerState<EditTarifScreen> createState() => _EditTarifScreenState();
}

class _EditTarifScreenState extends ConsumerState<EditTarifScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Kiloan
  late TextEditingController _cg3Controller;
  late TextEditingController _cg2Controller;
  late TextEditingController _cg1Controller;
  late TextEditingController _ck3Controller;
  late TextEditingController _ck2Controller;
  late TextEditingController _ck1Controller;
  late TextEditingController _expressController;

  // Satuan
  late TextEditingController _spreiKecilController;
  late TextEditingController _spreiBesarController;
  late TextEditingController _selimutKecilController;
  late TextEditingController _selimutBesarController;
  late TextEditingController _sepatuController;
  late TextEditingController _bonekaController;
  late TextEditingController _karpetKecilController;
  late TextEditingController _karpetBesarController;

  @override
  void initState() {
    super.initState();
    final currentRates = ref.read(pricingProvider);
    _cg3Controller = TextEditingController(text: currentRates.cuciGosok3Hari.toString());
    _cg2Controller = TextEditingController(text: currentRates.cuciGosok2Hari.toString());
    _cg1Controller = TextEditingController(text: currentRates.cuciGosok1Hari.toString());
    _ck3Controller = TextEditingController(text: currentRates.cuciKering3Hari.toString());
    _ck2Controller = TextEditingController(text: currentRates.cuciKering2Hari.toString());
    _ck1Controller = TextEditingController(text: currentRates.cuciKering1Hari.toString());
    _expressController = TextEditingController(text: currentRates.expressRate.toString());

    _spreiKecilController = TextEditingController(text: currentRates.spreiKecil.toString());
    _spreiBesarController = TextEditingController(text: currentRates.spreiBesar.toString());
    _selimutKecilController = TextEditingController(text: currentRates.selimutKecil.toString());
    _selimutBesarController = TextEditingController(text: currentRates.selimutBesar.toString());
    _sepatuController = TextEditingController(text: currentRates.sepatu.toString());
    _bonekaController = TextEditingController(text: currentRates.boneka.toString());
    _karpetKecilController = TextEditingController(text: currentRates.karpetKecil.toString());
    _karpetBesarController = TextEditingController(text: currentRates.karpetBesar.toString());
  }

  @override
  void dispose() {
    _cg3Controller.dispose();
    _cg2Controller.dispose();
    _cg1Controller.dispose();
    _ck3Controller.dispose();
    _ck2Controller.dispose();
    _ck1Controller.dispose();
    _expressController.dispose();
    _spreiKecilController.dispose();
    _spreiBesarController.dispose();
    _selimutKecilController.dispose();
    _selimutBesarController.dispose();
    _sepatuController.dispose();
    _bonekaController.dispose();
    _karpetKecilController.dispose();
    _karpetBesarController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixText: 'Rp ',
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Wajib diisi';
          if (int.tryParse(value) == null) return 'Harus berupa angka';
          return null;
        },
      ),
    );
  }

  void _handleSimpan() async {
    if (_formKey.currentState!.validate()) {
      final newRates = PricingRates(
        cuciGosok3Hari: int.parse(_cg3Controller.text),
        cuciGosok2Hari: int.parse(_cg2Controller.text),
        cuciGosok1Hari: int.parse(_cg1Controller.text),
        cuciKering3Hari: int.parse(_ck3Controller.text),
        cuciKering2Hari: int.parse(_ck2Controller.text),
        cuciKering1Hari: int.parse(_ck1Controller.text),
        expressRate: int.parse(_expressController.text),
        spreiKecil: int.parse(_spreiKecilController.text),
        spreiBesar: int.parse(_spreiBesarController.text),
        selimutKecil: int.parse(_selimutKecilController.text),
        selimutBesar: int.parse(_selimutBesarController.text),
        sepatu: int.parse(_sepatuController.text),
        boneka: int.parse(_bonekaController.text),
        karpetKecil: int.parse(_karpetKecilController.text),
        karpetBesar: int.parse(_karpetBesarController.text),
      );

      await ref.read(pricingProvider.notifier).savePrices(newRates);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tarif berhasil diperbarui!'),
            backgroundColor: AppTheme.incomeColor,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Tarif Layanan', style: TextStyle(color: Colors.white)),
          backgroundColor: AppTheme.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: AppTheme.accentColor,
            tabs: [
              Tab(text: 'Tarif Kiloan'),
              Tab(text: 'Tarif Satuan'),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    // Tab 1: Kiloan
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Tarif Cuci Gosok (/kg)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          _buildTextField('3 Hari', _cg3Controller),
                          _buildTextField('2 Hari', _cg2Controller),
                          _buildTextField('1 Hari', _cg1Controller),
                          
                          const SizedBox(height: 16),
                          const Text('Tarif Cuci Kering (/kg)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          _buildTextField('3 Hari', _ck3Controller),
                          _buildTextField('2 Hari', _ck2Controller),
                          _buildTextField('1 Hari', _ck1Controller),

                          const SizedBox(height: 16),
                          const Text('Tarif Spesial', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          _buildTextField('Express (6-8 Jam)', _expressController),
                        ],
                      ),
                    ),
                    // Tab 2: Satuan
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Sprei & Selimut', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          _buildTextField('Sprei Kecil (Single)', _spreiKecilController),
                          _buildTextField('Sprei Besar (King/Queen)', _spreiBesarController),
                          _buildTextField('Selimut Kecil/Tipis', _selimutKecilController),
                          _buildTextField('Selimut Besar/Bedcover', _selimutBesarController),
                          
                          const SizedBox(height: 16),
                          const Text('Lainnya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          _buildTextField('Sepatu', _sepatuController),
                          _buildTextField('Boneka', _bonekaController),
                          _buildTextField('Karpet Kecil/Tipis', _karpetKecilController),
                          _buildTextField('Karpet Besar/Tebal', _karpetBesarController),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                  onPressed: _handleSimpan,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Simpan Perubahan', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
