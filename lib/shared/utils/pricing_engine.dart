// lib/shared/utils/pricing_engine.dart

import 'package:laundry_jennaira/features/settings/providers/pricing_provider.dart';

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
    switch (item) {
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

  /// Calculates the total price and discount for an order.
  /// Returns a record `(totalPrice, discountAmount)`.
  static ({int totalPrice, int discountAmount}) calculatePrice({
    required PricingRates rates,
    required String serviceType, // 'Cuci Kering', 'Cuci Gosok', or 'Satuan'
    required double weightKg,
    required String duration, // '3 Hari', '2 Hari', '1 Hari', 'Express (6-8 Jam)'
    required String selectedItem,
    required int quantity,
  }) {
    int totalPrice = 0;
    int discountAmount = 0;

    if (serviceType == 'Cuci Kering' || serviceType == 'Cuci Gosok') {
      double effectiveWeight = weightKg;
      int rate = 0;
      int diskon1Hari = 0;

      if (serviceType == 'Cuci Gosok') {
        if (duration == '3 Hari') rate = rates.cuciGosok3Hari;
        else if (duration == '2 Hari') rate = rates.cuciGosok2Hari;
        else if (duration == '1 Hari') rate = rates.cuciGosok1Hari;
        diskon1Hari = rates.cuciGosok1Hari;
      } else if (serviceType == 'Cuci Kering') {
        if (duration == '3 Hari') rate = rates.cuciKering3Hari;
        else if (duration == '2 Hari') rate = rates.cuciKering2Hari;
        else if (duration == '1 Hari') rate = rates.cuciKering1Hari;
        diskon1Hari = rates.cuciKering1Hari;
      }

      if (duration == 'Express (6-8 Jam)') {
        rate = rates.expressRate;
        if (effectiveWeight > 0 && effectiveWeight < 1.5) {
          effectiveWeight = 1.5;
        }
      }

      totalPrice = (effectiveWeight * rate).round();

      if (duration == '1 Hari' && effectiveWeight > 5.0) {
        discountAmount = diskon1Hari;
      }
    } else if (serviceType == 'Satuan') {
      int itemPrice = getSatuanPrice(selectedItem, rates);
      totalPrice = itemPrice * quantity;
      discountAmount = 0;
    }

    return (totalPrice: totalPrice, discountAmount: discountAmount);
  }
}
