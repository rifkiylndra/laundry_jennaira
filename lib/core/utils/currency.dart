// lib/core/utils/currency.dart

import 'package:intl/intl.dart';

/// Formats a number to Indonesian Rupiah (IDR) currency format.
/// Example: 15000 -> "Rp 15.000"
String formatRupiah(num amount) {
  final formatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatter.format(amount);
}
