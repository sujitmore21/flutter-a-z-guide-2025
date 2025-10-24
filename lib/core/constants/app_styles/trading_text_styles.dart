import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors/trading_colors.dart';

/// Trading UI Kit Typography System
/// Provides consistent text styles for trading applications
class TradingTextStyles {
  // Private constructor to prevent instantiation
  TradingTextStyles._();

  // Font Family - using Google Fonts Inter

  // Base Text Style
  static TextStyle _baseStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Display Styles (Large Headers)
  static TextStyle displayLarge({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 48.0,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? TradingColors.textPrimary,
      height: 1.2,
      letterSpacing: -0.5,
    );
  }

  static TextStyle displayMedium({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 40.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.3,
      letterSpacing: -0.25,
    );
  }

  static TextStyle displaySmall({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 32.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.3,
    );
  }

  // Headline Styles
  static TextStyle headlineLarge({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 28.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.3,
    );
  }

  static TextStyle headlineMedium({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 24.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.3,
    );
  }

  static TextStyle headlineSmall({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 20.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.4,
    );
  }

  // Title Styles
  static TextStyle titleLarge({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 18.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.4,
    );
  }

  static TextStyle titleMedium({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 16.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.4,
    );
  }

  static TextStyle titleSmall({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 14.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.4,
    );
  }

  // Body Styles
  static TextStyle bodyLarge({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 16.0,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? TradingColors.textPrimary,
      height: 1.5,
    );
  }

  static TextStyle bodyMedium({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 14.0,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? TradingColors.textPrimary,
      height: 1.5,
    );
  }

  static TextStyle bodySmall({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 12.0,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? TradingColors.textSecondary,
      height: 1.5,
    );
  }

  // Label Styles
  static TextStyle labelLarge({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 14.0,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? TradingColors.textSecondary,
      height: 1.4,
    );
  }

  static TextStyle labelMedium({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 12.0,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? TradingColors.textSecondary,
      height: 1.4,
    );
  }

  static TextStyle labelSmall({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 10.0,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? TradingColors.textTertiary,
      height: 1.4,
    );
  }

  // Trading Specific Styles
  static TextStyle priceLarge({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 24.0,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? TradingColors.textPrimary,
      height: 1.2,
      letterSpacing: 0.5,
    );
  }

  static TextStyle priceMedium({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 18.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.3,
      letterSpacing: 0.25,
    );
  }

  static TextStyle priceSmall({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 14.0,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? TradingColors.textPrimary,
      height: 1.3,
      letterSpacing: 0.25,
    );
  }

  // Profit/Loss Styles
  static TextStyle profit({double fontSize = 14.0, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: TradingColors.profit,
      height: 1.3,
    );
  }

  static TextStyle loss({double fontSize = 14.0, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: TradingColors.loss,
      height: 1.3,
    );
  }

  static TextStyle neutral({double fontSize = 14.0, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: TradingColors.neutral,
      height: 1.3,
    );
  }

  // Caption Styles
  static TextStyle caption({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 10.0,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? TradingColors.textTertiary,
      height: 1.4,
    );
  }

  // Overline Styles
  static TextStyle overline({Color? color, FontWeight? fontWeight}) {
    return _baseStyle(
      fontSize: 10.0,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? TradingColors.textTertiary,
      height: 1.4,
      letterSpacing: 1.5,
    );
  }
}
