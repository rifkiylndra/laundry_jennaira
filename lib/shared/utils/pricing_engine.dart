// lib/shared/utils/pricing_engine.dart

import 'package:laundry_jennaira/features/settings/providers/pricing_provider.dart';
import 'package:laundry_jennaira/shared/models/order_model.dart';

class PricingEngine {
  static const List<String> satuanItems = [
    'Sprei Kecil (Single)',
    'Sprei Besar (King/Queen)',
    'Selimut Kecil/Tipis',
    'Selimut Besar/Bedcover',
    'Sepatu',
    'Boneka',
    'Karpet Kecil/Tipis',
    'Karpet Besar/Tebal',
  ];

  static int getSatuanPrice(String item, PricingRates rates) {
    // Strip "Satuan - " prefix if present to be robust
    final cleanItem = item.startsWith('Satuan - ') ? item.substring(9) : item;
    switch (cleanItem) {
      case 'Sprei Kecil (Single)': return rates.spreiKecil;
      case 'Sprei Besar (King/Queen)': return rates.spreiBesar;
      case 'Selimut Kecil/Tipis': return rates.selimutKecil;
      case 'Selimut Besar/Bedcover': return rates.selimutBesar;
      case 'Sepatu': return rates.sepatu;
      case 'Boneka': return rates.boneka;
      case 'Karpet Kecil/Tipis': return rates.karpetKecil;
      case 'Karpet Besar/Tebal': return rates.karpetBesar;
      default: return 12000;
    }
  }

  /// Calculates the total price and discount for an order based on items list and duration in days.
  /// Returns a record `(totalPrice, discountAmount)`.
  /// durationDays: 0 for Express, 1 for 1 Day, 2 for 2 Days, 3 for 3 Days.
  static ({int totalPrice, int discountAmount}) calculatePrice({
    required PricingRates rates,
    required List<OrderItem> items,
    required int durationDays,
  }) {
    int totalPrice = 0;
    int discountAmount = 0;

    for (var item in items) {
      final name = item.serviceName;
      final weightOrQty = item.weightOrQty;

      if (name == 'Cuci Gosok' || name == 'Cuci Kering' || name == 'Setrika') {
        double effectiveWeight = weightOrQty;
        int rate = 0;
        int diskon1Hari = 0;

        if (name == 'Cuci Gosok') {
          if (durationDays == 3) {
            rate = rates.cuciGosok3Hari;
          } else if (durationDays == 2) {
            rate = rates.cuciGosok2Hari;
          } else if (durationDays == 1) {
            rate = rates.cuciGosok1Hari;
          }
          diskon1Hari = rates.cuciGosok1Hari;
        } else {
          // 'Cuci Kering' and 'Setrika' share the same rates
          if (durationDays == 3) {
            rate = rates.cuciKering3Hari;
          } else if (durationDays == 2) {
            rate = rates.cuciKering2Hari;
          } else if (durationDays == 1) {
            rate = rates.cuciKering1Hari;
          }
          diskon1Hari = rates.cuciKering1Hari;
        }

        if (durationDays == 0) { // Express
          rate = rates.expressRate;
          if (effectiveWeight > 0 && effectiveWeight < 1.5) {
            effectiveWeight = 1.5;
          }
        }

        totalPrice += (effectiveWeight * rate).round();

        if (durationDays == 1 && effectiveWeight > 5.0) {
          discountAmount += diskon1Hari;
        }
      } else {
        // Satuan items
        int itemPrice = getSatuanPrice(name, rates);
        totalPrice += (itemPrice * weightOrQty).round();
      }
    }

    return (totalPrice: totalPrice, discountAmount: discountAmount);
  }
}
