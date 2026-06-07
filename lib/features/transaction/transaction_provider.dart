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
      throw Exception('Gagal mengambil data transaksi: $e');
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
      throw Exception('Gagal menyimpan transaksi: $e');
    }
  }
}
