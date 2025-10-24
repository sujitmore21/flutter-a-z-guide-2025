import 'package:flutter/material.dart';

/// Trading UI Kit Color System
/// Provides a comprehensive color palette for trading applications
class TradingColors {
  // Private constructor to prevent instantiation
  TradingColors._();

  // Primary Colors
  static const Color primary = Color(0xFF1E3A8A);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1E40AF);

  // Secondary Colors
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);

  // Trading Specific Colors
  static const Color profit = Color(0xFF10B981); // Green for profits
  static const Color loss = Color(0xFFEF4444); // Red for losses
  static const Color neutral = Color(0xFF6B7280); // Gray for neutral

  // Background Colors
  static const Color background = Color(0xFF0F172A);
  static const Color surface = Color(0xFF1E293B);
  static const Color surfaceLight = Color(0xFF334155);
  static const Color surfaceDark = Color(0xFF0F172A);

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFCBD5E1);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textDisabled = Color(0xFF64748B);

  // Border Colors
  static const Color border = Color(0xFF334155);
  static const Color borderLight = Color(0xFF475569);
  static const Color borderDark = Color(0xFF1E293B);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Chart Colors
  static const Color chartGreen = Color(0xFF10B981);
  static const Color chartRed = Color(0xFFEF4444);
  static const Color chartBlue = Color(0xFF3B82F6);
  static const Color chartPurple = Color(0xFF8B5CF6);
  static const Color chartOrange = Color(0xFFF59E0B);
  static const Color chartPink = Color(0xFFEC4899);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient profitGradient = LinearGradient(
    colors: [profit, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lossGradient = LinearGradient(
    colors: [loss, Color(0xFFF87171)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkText = Color(0xFFF8FAFC);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1E293B);
}
