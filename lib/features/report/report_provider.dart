// lib/features/report/report_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/features/transaction/transaction_provider.dart';

class ReportState {
  final DateTime selectedMonth;
  final int totalIncome;
  final int totalExpense;
  final int netProfit;
  final List<double> weeklyTrend;

  ReportState({
    required this.selectedMonth,
    required this.totalIncome,
    required this.totalExpense,
    required this.netProfit,
    required this.weeklyTrend,
  });

  ReportState copyWith({
    DateTime? selectedMonth,
    int? totalIncome,
    int? totalExpense,
    int? netProfit,
    List<double>? weeklyTrend,
  }) {
    return ReportState(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      netProfit: netProfit ?? this.netProfit,
      weeklyTrend: weeklyTrend ?? this.weeklyTrend,
    );
  }
}

class ReportNotifier extends StateNotifier<ReportState> {
  final Ref ref;

  ReportNotifier(this.ref)
      : super(ReportState(
          selectedMonth: DateTime.now(),
          totalIncome: 0,
          totalExpense: 0,
          netProfit: 0,
          weeklyTrend: [0, 0, 0, 0],
        )) {
    _calculateStats();
    
    // Listen to transaction changes to recalculate
    ref.listen(transactionNotifierProvider, (previous, next) {
      _calculateStats();
    });
  }

  void setMonth(DateTime month) {
    state = state.copyWith(selectedMonth: month);
    _calculateStats();
  }

  void _calculateStats() {
    final transactionsAsync = ref.read(transactionNotifierProvider);
    
    transactionsAsync.whenData((transactions) {
      int income = 0;
      int expense = 0;
      
      final currentMonth = state.selectedMonth;
      
      // Calculate 4-week trend (mock for simple UI)
      List<double> trend = [0, 0, 0, 0];

      for (var t in transactions) {
        final date = t.createdAt?.toLocal() ?? DateTime.now();
        if (date.year == currentMonth.year && date.month == currentMonth.month) {
          if (t.type == 'income') {
            income += t.amount;
            
            // Assign to week 1-4 for trend
            int weekIndex = (date.day - 1) ~/ 7;
            if (weekIndex > 3) weekIndex = 3;
            trend[weekIndex] += t.amount.toDouble();
            
          } else if (t.type == 'expense') {
            expense += t.amount;
          }
        }
      }

      state = state.copyWith(
        totalIncome: income,
        totalExpense: expense,
        netProfit: income - expense,
        weeklyTrend: trend,
      );
    });
  }

  void exportCsv() {
    final transactionsAsync = ref.read(transactionNotifierProvider);
    transactionsAsync.whenData((transactions) {
      final currentMonth = state.selectedMonth;
      
      String csv = "Tanggal,Tipe,Deskripsi,Jumlah\n";
      
      for (var t in transactions) {
        final date = t.createdAt?.toLocal() ?? DateTime.now();
        if (date.year == currentMonth.year && date.month == currentMonth.month) {
          csv += "${date.toIso8601String()},${t.type},${t.description ?? 'Tanpa Keterangan'},${t.amount}\n";
        }
      }
      
      // Print to console as requested
      print("===== EXPORT CSV =====");
      print(csv);
      print("======================");
    });
  }
}

final reportNotifierProvider = StateNotifierProvider<ReportNotifier, ReportState>((ref) {
  return ReportNotifier(ref);
});
