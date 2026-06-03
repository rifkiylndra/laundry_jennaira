// lib/shared/utils/pricing_engine.dart

class PricingEngine {
  // Cuci Gosok (Kiloan) Base Prices
  static const int kiloan3Hari = 5000;
  static const int kiloan2Hari = 6000;
  static const int kiloan1Hari = 7000;
  static const int kiloanExpress = 12000;

  // Satuan Base Prices
  static const Map<String, int> satuanPrices = {
    'Sprei': 15000,
    'Selimut': 20000,
    'Sepatu': 25000,
    'Boneka': 10000,
    'Karpet': 30000,
  };

  /// Calculates the total price and discount for an order.
  /// Returns a record `(totalPrice, discountAmount)`.
  static ({int totalPrice, int discountAmount}) calculatePrice({
    required String serviceType, // 'Kiloan' or 'Satuan'
    required double weightKg,
    required String duration, // '3 Hari', '2 Hari', '1 Hari', 'Express (6-8 Jam)'
    required String selectedItem,
    required int quantity,
  }) {
    int totalPrice = 0;
    int discountAmount = 0;

    if (serviceType == 'Kiloan') {
      double effectiveWeight = weightKg;
      int rate = kiloan3Hari;

      // Determine rate based on duration
      if (duration == '3 Hari') {
        rate = kiloan3Hari;
      } else if (duration == '2 Hari') {
        rate = kiloan2Hari;
      } else if (duration == '1 Hari') {
        rate = kiloan1Hari;
      } else if (duration == 'Express (6-8 Jam)') {
        rate = kiloanExpress;
        // Business Rule 1: Express Minimum Weight constraint
        if (effectiveWeight > 0 && effectiveWeight < 1.5) {
          effectiveWeight = 1.5;
        }
      }

      totalPrice = (effectiveWeight * rate).round();

      // Business Rule 2: Discount for 1 Hari > 5kg
      if (duration == '1 Hari' && effectiveWeight > 5.0) {
        discountAmount = kiloan1Hari; // Discount equals the price of 1kg of "1 Hari" service
      }
    } else if (serviceType == 'Satuan') {
      // Satuan logic
      int itemPrice = satuanPrices[selectedItem] ?? 10000;
      totalPrice = itemPrice * quantity;
      discountAmount = 0; // No discount for Satuan by default
    }

    return (totalPrice: totalPrice, discountAmount: discountAmount);
  }
}
