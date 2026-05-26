// lib/features/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:laundry_jennaira/app/theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<String> _titles = [
    'Beranda',
    'Daftar Order',
    'Daftar Transaksi',
    'Laporan Bulanan',
  ];

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const Center(child: Text('Beranda (Dashboard) Screen Placeholder', style: TextStyle(fontSize: 16)));
      case 1:
        return const Center(child: Text('Daftar Order Screen Placeholder', style: TextStyle(fontSize: 16)));
      case 2:
        return const Center(child: Text('Transaksi Screen Placeholder', style: TextStyle(fontSize: 16)));
      case 3:
        return const Center(child: Text('Laporan Screen Placeholder', style: TextStyle(fontSize: 16)));
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigation to settings will go here
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Laporan',
          ),
        ],
      ),
    );
  }
}
