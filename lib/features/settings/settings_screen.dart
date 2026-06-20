// lib/features/settings/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/features/auth/auth_provider.dart';
import 'package:laundry_jennaira/features/settings/screens/edit_tarif_screen.dart';
import 'package:laundry_jennaira/app/theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.price_change, color: AppTheme.primaryColor),
            title: const Text('Edit Tarif Layanan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditTarifScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Keluar (Logout)', style: TextStyle(color: Colors.red)),
            onTap: () {
              ref.read(authProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}
