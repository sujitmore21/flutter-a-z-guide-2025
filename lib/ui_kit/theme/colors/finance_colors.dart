import 'package:flutter/material.dart';

/// Finance & Fintech Color Palette
/// Comprehensive color system for banking, trading, and financial applications
class FinanceColors {
  // Primary Colors
  static const Color primary = Color(0xFF1E40AF); // Blue
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1E3A8A);

  // Secondary Colors
  static const Color secondary = Color(0xFF7C3AED); // Purple
  static const Color secondaryLight = Color(0xFF8B5CF6);
  static const Color secondaryDark = Color(0xFF6D28D9);

  // Success Colors (Green)
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  // Error Colors (Red)
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  // Warning Colors (Orange)
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  // Info Colors (Cyan)
  static const Color info = Color(0xFF06B6D4);
  static const Color infoLight = Color(0xFF22D3EE);
  static const Color infoDark = Color(0xFF0891B2);

  // Neutral Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  // Border Colors
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color borderDark = Color(0xFFCBD5E1);

  // Trading Specific Colors
  static const Color profit = Color(0xFF10B981); // Green for profits
  static const Color loss = Color(0xFFEF4444); // Red for losses
  static const Color neutral = Color(0xFF64748B); // Gray for neutral

  // Banking Specific Colors
  static const Color accountPrimary = Color(0xFF1E40AF);
  static const Color accountSecondary = Color(0xFF7C3AED);
  static const Color accountTertiary = Color(0xFF10B981);

  // Payment Method Colors
  static const Color creditCard = Color(0xFF1E40AF);
  static const Color debitCard = Color(0xFF7C3AED);
  static const Color digitalWallet = Color(0xFFF59E0B);
  static const Color upi = Color(0xFF06B6D4);

  // Status Colors
  static const Color statusActive = Color(0xFF10B981);
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusInactive = Color(0xFF64748B);
  static const Color statusError = Color(0xFFEF4444);

  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF1E40AF), // Blue
    Color(0xFF7C3AED), // Purple
    Color(0xFF10B981), // Green
    Color(0xFFF59E0B), // Orange
    Color(0xFFEF4444), // Red
    Color(0xFF06B6D4), // Cyan
    Color(0xFF8B5CF6), // Violet
    Color(0xFFF97316), // Orange Red
  ];

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
  );

  static const LinearGradient errorGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEF4444), Color(0xFFF87171)],
  );

  static const LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
  );

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSurfaceVariant = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextTertiary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF334155);

  // Utility Methods
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static Color lighten(Color color, double amount) {
    return Color.lerp(color, Colors.white, amount) ?? color;
  }

  static Color darken(Color color, double amount) {
    return Color.lerp(color, Colors.black, amount) ?? color;
  }

  // Get color by status
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'completed':
      case 'success':
        return success;
      case 'pending':
      case 'processing':
        return warning;
      case 'inactive':
      case 'cancelled':
      case 'failed':
        return error;
      default:
        return textSecondary;
    }
  }

  // Get color by transaction type
  static Color getTransactionColor(bool isCredit) {
    return isCredit ? profit : loss;
  }

  // Get color by amount change
  static Color getChangeColor(double change) {
    if (change > 0) return profit;
    if (change < 0) return loss;
    return neutral;
  }
}
