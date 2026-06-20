// lib/features/settings/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/app/theme.dart';
import 'package:laundry_jennaira/features/inventory/screens/inventory_screen.dart';
import 'package:laundry_jennaira/features/settings/screens/qris_settings_screen.dart';
import 'package:laundry_jennaira/features/settings/screens/end_of_day_screen.dart';
import 'package:laundry_jennaira/features/settings/screens/business_info_screen.dart';
import 'package:laundry_jennaira/features/settings/screens/edit_tarif_screen.dart';
import 'package:laundry_jennaira/features/auth/auth_provider.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC4C6D0).withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: AppTheme.primaryColor, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mas Zamzami',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text(
                            'Owner / Admin',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF747780), shape: BoxShape.circle)),
                          ),
                          const Text(
                            'v1.0.4',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Settings List Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC4C6D0).withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.payments,
                    title: 'Edit Tarif Layanan',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const EditTarifScreen()));
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFE0E3E5)),
                  _buildSettingTile(
                    icon: Icons.storefront,
                    title: 'Info Usaha',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const BusinessInfoScreen()));
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFE0E3E5)),
                  _buildSettingTile(
                    icon: Icons.qr_code_2,
                    title: 'Generate QRIS',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const QrisSettingsScreen()));
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFE0E3E5)),
                  _buildSettingTile(
                    icon: Icons.inventory_2,
                    title: 'Manajemen Stok (Inventory)',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const InventoryScreen()));
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFE0E3E5)),
                  _buildSettingTile(
                    icon: Icons.history_edu,
                    title: 'Tutup Buku Harian',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const EndOfDayScreen()));
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFE0E3E5)),
                  _buildSettingTile(
                    icon: Icons.logout,
                    title: 'Keluar',
                    isDanger: true,
                    onTap: () {
                      ref.read(authProvider.notifier).signOut();
                      context.go('/login');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Footer
            const Text(
              'Laundry Jennaira Business Suite',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Managed by System Admin',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: AppTheme.textSecondaryColor.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    bool isDanger = false,
    required VoidCallback onTap,
  }) {
    final color = isDanger ? AppTheme.expenseColor : AppTheme.primaryColor;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: isDanger ? FontWeight.w500 : FontWeight.normal,
                  color: isDanger ? color : AppTheme.textPrimaryColor,
                ),
              ),
            ),
            Icon(
              isDanger ? Icons.logout : Icons.chevron_right,
              color: isDanger ? color.withValues(alpha: 0.6) : const Color(0xFF747780),
            ),
          ],
        ),
      ),
    );
  }
}
