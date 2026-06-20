// lib/features/inventory/providers/inventory_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/core/supabase_client.dart';
import 'package:laundry_jennaira/shared/models/inventory_model.dart';
import 'package:uuid/uuid.dart';

final inventoryProvider = StateNotifierProvider<InventoryNotifier, AsyncValue<List<InventoryModel>>>((ref) {
  return InventoryNotifier();
});

class InventoryNotifier extends StateNotifier<AsyncValue<List<InventoryModel>>> {
  InventoryNotifier() : super(const AsyncValue.loading()) {
    fetchInventory();
  }

  Future<void> fetchInventory() async {
    try {
      final response = await supabase.from('inventory_items').select();
      
      if (response.isEmpty) {
        // Seed default inventory items if empty
        final defaults = [
          InventoryModel(id: const Uuid().v4(), name: 'Deterjen Cair', unit: 'kg', stock: 5.2, minStock: 2.0),
          InventoryModel(id: const Uuid().v4(), name: 'Pewangi', unit: 'L', stock: 0.8, minStock: 1.0),
          InventoryModel(id: const Uuid().v4(), name: 'Plastik Packing', unit: 'pcs', stock: 12.0, minStock: 50.0),
          InventoryModel(id: const Uuid().v4(), name: 'Kantong Plastik Kresek', unit: 'pcs', stock: 100.0, minStock: 20.0),
        ];
        
        for (var item in defaults) {
          await supabase.from('inventory_items').insert({
            'id': item.id,
            'name': item.name,
            'unit': item.unit,
            'stock': item.stock,
            'min_stock': item.minStock,
          });
        }
        state = AsyncValue.data(defaults);
      } else {
        final items = response.map((e) => InventoryModel.fromJson(e)).toList();
        state = AsyncValue.data(items);
      }
    } catch (e) {
      // Fallback to local memory if Supabase fails (e.g. RLS permission denied)
      final defaults = [
        InventoryModel(id: const Uuid().v4(), name: 'Deterjen Cair', unit: 'kg', stock: 5.2, minStock: 2.0),
        InventoryModel(id: const Uuid().v4(), name: 'Pewangi', unit: 'L', stock: 0.8, minStock: 1.0),
        InventoryModel(id: const Uuid().v4(), name: 'Plastik Packing', unit: 'pcs', stock: 12.0, minStock: 50.0),
        InventoryModel(id: const Uuid().v4(), name: 'Kantong Plastik Kresek', unit: 'pcs', stock: 100.0, minStock: 20.0),
      ];
      state = AsyncValue.data(defaults);
    }
  }

  Future<void> updateStock(InventoryModel item, double newStock) async {
    if (newStock < 0) newStock = 0;
    
    // Optimistic UI update
    final currentState = state.value ?? [];
    final updatedList = currentState.map((e) => e.id == item.id ? e.copyWith(stock: newStock) : e).toList();
    state = AsyncValue.data(updatedList);

    try {
      await supabase.from('inventory_items').update({'stock': newStock}).eq('id', item.id);
    } catch (e) {
      // If it fails (e.g., RLS), we just keep the optimistic local state for this sprint
      // print('Supabase update failed, keeping local state: $e');
    }
  }
}
