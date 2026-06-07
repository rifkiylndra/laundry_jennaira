// lib/features/dashboard/dashboard_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:laundry_jennaira/features/transaction/transaction_provider.dart';

part 'dashboard_provider.g.dart';

typedef DashboardStats = ({
  int todayOmzet,
  int todayExpense,
  int todayProfit,
  List<int> weeklyChartData,
});

@riverpod
DashboardStats dashboardStats(DashboardStatsRef ref) {
  final transactionsState = ref.watch(transactionNotifierProvider);

  return transactionsState.maybeWhen(
    data: (transactions) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      int omzet = 0;
      int expense = 0;
      List<int> weeklyData = List.filled(7, 0);

      for (var t in transactions) {
        final tDate = t.createdAt?.toLocal() ?? DateTime.now();
        final tDay = DateTime(tDate.year, tDate.month, tDate.day);
        
        if (tDay.isAtSameMomentAs(today)) {
          if (t.type == 'income') {
            omzet += t.amount;
          } else if (t.type == 'expense') {
            expense += t.amount;
          }
        }

        final difference = today.difference(tDay).inDays;
        if (difference >= 0 && difference <= 6) {
          if (t.type == 'income') {
            final index = 6 - difference;
            weeklyData[index] += t.amount;
          }
        }
      }

      return (
        todayOmzet: omzet,
        todayExpense: expense,
        todayProfit: omzet - expense,
        weeklyChartData: weeklyData,
      );
    },
    orElse: () => (
      todayOmzet: 0,
      todayExpense: 0,
      todayProfit: 0,
      weeklyChartData: List.filled(7, 0),
    ),
  );
}
