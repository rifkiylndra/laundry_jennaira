// lib/core/utils/date_helper.dart

import 'package:intl/intl.dart';

class DateHelper {
  /// Formats a DateTime to a human-readable format.
  /// Example: 2026-05-20 15:30 -> "20 Mei 2026, 15:30"
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('d MMM yyyy, HH:mm', 'id').format(dateTime);
  }

  /// Formats a DateTime to date only.
  /// Example: 2026-05-20 -> "20 Mei 2026"
  static String formatDate(DateTime dateTime) {
    return DateFormat('d MMM yyyy', 'id').format(dateTime);
  }

  /// Formats a DateTime to month and year.
  /// Example: 2026-05-20 -> "Mei 2026"
  static String formatMonthYear(DateTime dateTime) {
    return DateFormat('MMMM yyyy', 'id').format(dateTime);
  }

  /// Formats a DateTime to time only.
  /// Example: 15:30
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  /// Returns a friendly date label for headers (e.g. "Hari Ini", "Kemarin", or date string).
  static String getFriendlyDateLabel(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (targetDate == today) {
      return 'Hari Ini';
    } else if (targetDate == yesterday) {
      return 'Kemarin';
    } else {
      return DateFormat('EEEE, d MMMM yyyy', 'id').format(dateTime);
    }
  }
}
