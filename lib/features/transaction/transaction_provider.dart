// lib/features/transaction/transaction_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:laundry_jennaira/core/supabase_client.dart';
import 'package:laundry_jennaira/shared/models/transaction_model.dart';

part 'transaction_provider.g.dart';

@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  @override
  Future<List<TransactionModel>> build() async {
    return _fetchTransactions();
  }

  Future<List<TransactionModel>> _fetchTransactions() async {
    try {
      final response = await supabase
          .from('transactions')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json) => TransactionModel.fromJson(json)).toList();
    } catch (e) {
      // Offline resilience handled by try-catch
      throw Exception('Koneksi Terputus. Gagal mengambil data transaksi.');
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchTransactions());
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      final data = {
        'type': transaction.type,
        'amount': transaction.amount,
        'note': transaction.description,
      };
      if (transaction.orderId != null) {
        data['order_id'] = transaction.orderId;
      }

      await supabase.from('transactions').insert(data);
      
      // Refresh the list after successful insertion
      await refresh();
    } catch (e) {
      throw Exception('Koneksi Terputus. Gagal menyimpan data.');
    }
  }

  List<TransactionModel> getTransactionsByDate(DateTime date) {
    final currentState = state.value ?? [];
    return currentState.where((t) {
      final local = t.createdAt.toLocal();
      return local.year == date.year && local.month == date.month && local.day == date.day;
    }).toList();
  }

  List<TransactionModel> getTransactionsByMonth(DateTime monthYear) {
    final currentState = state.value ?? [];
    return currentState.where((t) {
      final local = t.createdAt.toLocal();
      return local.year == monthYear.year && local.month == monthYear.month;
    }).toList();
  }

  Map<String, int> getEndOfDaySummary() {
    final todayTxs = getTransactionsByDate(DateTime.now());
    int totalCash = 0;
    int totalQris = 0;
    int totalExpense = 0;

    for (var t in todayTxs) {
      if (t.type == 'income') {
        if (t.paymentMethod == 'QRIS') {
          totalQris += t.amount;
        } else {
          // Default to CASH if null or other
          totalCash += t.amount;
        }
      } else if (t.type == 'expense') {
        totalExpense += t.amount;
      }
    }

    return {
      'totalCash': totalCash,
      'totalQris': totalQris,
      'totalExpense': totalExpense,
    };
  }
}
