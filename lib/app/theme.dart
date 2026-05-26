// lib/app/theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  // Hex Color Tokens from DESIGN.md
  static const Color primaryColor = Color(0xFF0F2D5E);
  static const Color accentColor = Color(0xFF2563EB);
  static const Color incomeColor = Color(0xFF166534);
  static const Color expenseColor = Color(0xFF991B1B);
  static const Color warningColor = Color(0xFF9A3412);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimaryColor = Color(0xFF374151);
  static const Color textSecondaryColor = Color(0xFF64748B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: accentColor,
        onSecondary: Colors.white,
        error: expenseColor,
        onError: Colors.white,
        surface: cardColor,
        onSurface: textPrimaryColor,
        errorContainer: Color(0xFFFEE2E2), // Red 100
        onErrorContainer: expenseColor,
      ),
      cardTheme: const CardThemeData(
        color: cardColor,
        elevation: 0.5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentColor,
          side: const BorderSide(color: Color(0xFFCBD5E1), width: 1),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: expenseColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: expenseColor, width: 2),
        ),
        labelStyle: const TextStyle(color: textSecondaryColor, fontSize: 14),
        hintStyle: const TextStyle(color: textSecondaryColor, fontSize: 14),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: accentColor,
        unselectedLabelColor: textSecondaryColor,
        indicatorColor: accentColor,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: accentColor,
        unselectedItemColor: textSecondaryColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 32, letterSpacing: -0.5),
        headlineMedium: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: -0.5),
        headlineSmall: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -0.5),
        titleLarge: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 18),
        titleMedium: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.w600, fontSize: 16),
        titleSmall: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.w500, fontSize: 14),
        bodyLarge: TextStyle(color: textPrimaryColor, fontSize: 16),
        bodyMedium: TextStyle(color: textPrimaryColor, fontSize: 14),
        bodySmall: TextStyle(color: textSecondaryColor, fontSize: 12),
        labelLarge: TextStyle(color: textSecondaryColor, fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }
}
