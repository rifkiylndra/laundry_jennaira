// lib/features/transaction/transaction_list_screen.dart

import 'package:flutter/material.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Transaksi'),
      ),
      body: const Center(
        child: Text('Halaman Transaksi'),
      ),
    );
  }
}
