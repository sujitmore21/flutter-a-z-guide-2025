import 'package:flutter/material.dart';

/// E-Commerce & Retail Color Palette
/// Comprehensive color system for shopping and retail applications
class EcommerceColors {
  // Primary Colors
  static const Color primary = Color(0xFF2563EB); // Blue
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);

  // Secondary Colors
  static const Color secondary = Color(0xFF7C3AED); // Purple
  static const Color secondaryLight = Color(0xFF8B5CF6);
  static const Color secondaryDark = Color(0xFF6D28D9);

  // Accent Colors
  static const Color accent = Color(0xFFF59E0B); // Orange
  static const Color accentLight = Color(0xFFFBBF24);
  static const Color accentDark = Color(0xFFD97706);

  // Success Colors (Green)
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  // Error Colors (Red)
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  // Warning Colors (Yellow)
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

  // Product Specific Colors
  static const Color productCard = Color(0xFFFFFFFF);
  static const Color productImage = Color(0xFFF8FAFC);
  static const Color productPrice = Color(0xFF1E293B);
  static const Color productOriginalPrice = Color(0xFF94A3B8);
  static const Color productSale = Color(0xFFEF4444);
  static const Color productNew = Color(0xFF10B981);

  // Shopping Cart Colors
  static const Color cartItem = Color(0xFFFFFFFF);
  static const Color cartTotal = Color(0xFF1E293B);
  static const Color cartDiscount = Color(0xFF10B981);
  static const Color cartShipping = Color(0xFF64748B);

  // Checkout Colors
  static const Color checkoutForm = Color(0xFFFFFFFF);
  static const Color checkoutStep = Color(0xFF2563EB);
  static const Color checkoutStepCompleted = Color(0xFF10B981);
  static const Color checkoutStepPending = Color(0xFF94A3B8);

  // Payment Colors
  static const Color paymentCard = Color(0xFF1E40AF);
  static const Color paymentPayPal = Color(0xFF0070BA);
  static const Color paymentApple = Color(0xFF000000);
  static const Color paymentGoogle = Color(0xFF4285F4);

  // Status Colors
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusProcessing = Color(0xFF06B6D4);
  static const Color statusShipped = Color(0xFF10B981);
  static const Color statusDelivered = Color(0xFF10B981);
  static const Color statusCancelled = Color(0xFFEF4444);
  static const Color statusReturned = Color(0xFF64748B);

  // Category Colors
  static const Color categoryElectronics = Color(0xFF2563EB);
  static const Color categoryFashion = Color(0xFF7C3AED);
  static const Color categoryHome = Color(0xFF10B981);
  static const Color categorySports = Color(0xFFF59E0B);
  static const Color categoryBooks = Color(0xFFEF4444);
  static const Color categoryBeauty = Color(0xFFEC4899);

  // Rating Colors
  static const Color ratingStar = Color(0xFFF59E0B);
  static const Color ratingStarEmpty = Color(0xFFE2E8F0);

  // Badge Colors
  static const Color badgeSale = Color(0xFFEF4444);
  static const Color badgeNew = Color(0xFF10B981);
  static const Color badgeHot = Color(0xFFF59E0B);
  static const Color badgeLimited = Color(0xFF7C3AED);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
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
      case 'pending':
        return statusPending;
      case 'processing':
        return statusProcessing;
      case 'shipped':
        return statusShipped;
      case 'delivered':
        return statusDelivered;
      case 'cancelled':
        return statusCancelled;
      case 'returned':
        return statusReturned;
      default:
        return textSecondary;
    }
  }

  // Get color by category
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return categoryElectronics;
      case 'fashion':
        return categoryFashion;
      case 'home':
        return categoryHome;
      case 'sports':
        return categorySports;
      case 'books':
        return categoryBooks;
      case 'beauty':
        return categoryBeauty;
      default:
        return primary;
    }
  }

  // Get color by payment method
  static Color getPaymentColor(String method) {
    switch (method.toLowerCase()) {
      case 'credit_card':
        return paymentCard;
      case 'paypal':
        return paymentPayPal;
      case 'apple_pay':
        return paymentApple;
      case 'google_pay':
        return paymentGoogle;
      default:
        return primary;
    }
  }
}
