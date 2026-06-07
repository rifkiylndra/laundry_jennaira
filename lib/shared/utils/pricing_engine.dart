// lib/shared/utils/pricing_engine.dart

class PricingEngine {
  // Cuci Gosok Base Prices
  static const int cuciGosok3Hari = 5000;
  static const int cuciGosok2Hari = 6000;
  static const int cuciGosok1Hari = 7000;

  // Cuci Kering Base Prices (Gosok - 1000)
  static const int cuciKering3Hari = 4000;
  static const int cuciKering2Hari = 5000;
  static const int cuciKering1Hari = 6000;

  static const int expressRate = 12000;

  // Satuan Base Prices
  static const Map<String, int> satuanPrices = {
    'Sprei': 12000,
    'Selimut': 25000,
    'Sepatu': 20000,
    'Boneka': 15000,
    'Karpet': 35000,
  };

  /// Calculates the total price and discount for an order.
  /// Returns a record `(totalPrice, discountAmount)`.
  static ({int totalPrice, int discountAmount}) calculatePrice({
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
        if (duration == '3 Hari') rate = cuciGosok3Hari;
        else if (duration == '2 Hari') rate = cuciGosok2Hari;
        else if (duration == '1 Hari') rate = cuciGosok1Hari;
        diskon1Hari = cuciGosok1Hari;
      } else if (serviceType == 'Cuci Kering') {
        if (duration == '3 Hari') rate = cuciKering3Hari;
        else if (duration == '2 Hari') rate = cuciKering2Hari;
        else if (duration == '1 Hari') rate = cuciKering1Hari;
        diskon1Hari = cuciKering1Hari;
      }

      if (duration == 'Express (6-8 Jam)') {
        rate = expressRate;
        if (effectiveWeight > 0 && effectiveWeight < 1.5) {
          effectiveWeight = 1.5;
        }
      }

      totalPrice = (effectiveWeight * rate).round();

      if (duration == '1 Hari' && effectiveWeight > 5.0) {
        discountAmount = diskon1Hari;
      }
    } else if (serviceType == 'Satuan') {
      int itemPrice = satuanPrices[selectedItem] ?? 12000;
      totalPrice = itemPrice * quantity;
      discountAmount = 0;
    }

    return (totalPrice: totalPrice, discountAmount: discountAmount);
  }
}
