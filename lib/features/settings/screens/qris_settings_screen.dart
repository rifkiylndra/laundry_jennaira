// lib/features/settings/screens/qris_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/core/supabase_client.dart';

class QrisSettingsScreen extends StatefulWidget {
  const QrisSettingsScreen({super.key});

  @override
  State<QrisSettingsScreen> createState() => _QrisSettingsScreenState();
}

class _QrisSettingsScreenState extends State<QrisSettingsScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String? _qrisUrl;

  @override
  void initState() {
    super.initState();
    _loadQrisImage();
  }

  void _loadQrisImage() {
    // Generate the public URL
    // We add a timestamp query parameter to bypass cache if image updates
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final url = supabase.storage.from('settings').getPublicUrl('qris/active_qris.png');
    setState(() {
      _qrisUrl = '$url?t=$timestamp';
    });
  }

  Future<void> _pickAndUploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() => _isLoading = true);

      final bytes = await image.readAsBytes();

      // Upload to Supabase Storage
      await supabase.storage.from('settings').uploadBinary(
            'qris/active_qris.png',
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gambar QRIS berhasil diperbarui!'),
            backgroundColor: AppTheme.incomeColor,
          ),
        );
        _loadQrisImage(); // Refresh the displayed image
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengupload QRIS: $e'),
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
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Atur QRIS', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pengaturan QRIS Toko',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Gambar QRIS ini akan ditampilkan di menu pembayaran untuk memudahkan pelanggan yang ingin membayar dengan e-Wallet atau m-Banking.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFCBD5E1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  if (_qrisUrl != null)
                    Image.network(
                      _qrisUrl!,
                      height: 300,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 300,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.qr_code_scanner, size: 64, color: Color(0xFFCBD5E1)),
                              SizedBox(height: 16),
                              Text('Belum ada QRIS yang diatur', style: TextStyle(color: AppTheme.textSecondaryColor)),
                            ],
                          ),
                        );
                      },
                    )
                  else
                    const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: _isLoading ? null : _pickAndUploadImage,
                      icon: _isLoading 
                          ? const SizedBox(
                              width: 20, height: 20, 
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                            )
                          : const Icon(Icons.upload_file),
                      label: Text(
                        _isLoading ? 'Mengupload...' : 'Pilih dari Galeri',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
