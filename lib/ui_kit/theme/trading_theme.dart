import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors/trading_colors.dart';
import '../../core/constants/app_sizes/trading_sizes.dart';
import '../../core/constants/app_styles/trading_text_styles.dart';

/// Trading UI Kit Theme Configuration
/// Provides comprehensive theming for trading applications
class TradingTheme {
  // Private constructor to prevent instantiation
  TradingTheme._();

  /// Dark Theme for Trading Applications
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: TradingColors.primary,
        primaryContainer: TradingColors.primaryDark,
        secondary: TradingColors.secondary,
        secondaryContainer: TradingColors.secondaryDark,
        surface: TradingColors.surface,
        surfaceContainerHighest: TradingColors.surfaceLight,
        background: TradingColors.background,
        error: TradingColors.error,
        onPrimary: TradingColors.textPrimary,
        onSecondary: TradingColors.textPrimary,
        onSurface: TradingColors.textPrimary,
        onBackground: TradingColors.textPrimary,
        onError: TradingColors.textPrimary,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: TradingColors.surface,
        foregroundColor: TradingColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TradingTextStyles.titleLarge(),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: TradingColors.surface,
        elevation: 2,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusMd),
        ),
        margin: const EdgeInsets.all(TradingSizes.sm),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TradingColors.primary,
          foregroundColor: TradingColors.textPrimary,
          elevation: 2,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: TradingSizes.lg,
            vertical: TradingSizes.md,
          ),
          textStyle: TradingTextStyles.labelLarge(),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: TradingColors.textPrimary,
          side: const BorderSide(color: TradingColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: TradingSizes.lg,
            vertical: TradingSizes.md,
          ),
          textStyle: TradingTextStyles.labelLarge(),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: TradingColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: TradingSizes.md,
            vertical: TradingSizes.sm,
          ),
          textStyle: TradingTextStyles.labelLarge(),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TradingColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: TradingSizes.md,
          vertical: TradingSizes.md,
        ),
        hintStyle: TradingTextStyles.bodyMedium(
          color: TradingColors.textTertiary,
        ),
        labelStyle: TradingTextStyles.labelMedium(),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: TradingColors.surface,
        selectedItemColor: TradingColors.primary,
        unselectedItemColor: TradingColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: TradingColors.primary,
        foregroundColor: TradingColors.textPrimary,
        elevation: 4,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: TradingColors.border,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: TradingColors.textSecondary,
        size: TradingSizes.iconMd,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: TradingTextStyles.displayLarge(),
        displayMedium: TradingTextStyles.displayMedium(),
        displaySmall: TradingTextStyles.displaySmall(),
        headlineLarge: TradingTextStyles.headlineLarge(),
        headlineMedium: TradingTextStyles.headlineMedium(),
        headlineSmall: TradingTextStyles.headlineSmall(),
        titleLarge: TradingTextStyles.titleLarge(),
        titleMedium: TradingTextStyles.titleMedium(),
        titleSmall: TradingTextStyles.titleSmall(),
        bodyLarge: TradingTextStyles.bodyLarge(),
        bodyMedium: TradingTextStyles.bodyMedium(),
        bodySmall: TradingTextStyles.bodySmall(),
        labelLarge: TradingTextStyles.labelLarge(),
        labelMedium: TradingTextStyles.labelMedium(),
        labelSmall: TradingTextStyles.labelSmall(),
      ),

      // Scaffold Background
      scaffoldBackgroundColor: TradingColors.background,
    );
  }

  /// Light Theme for Trading Applications
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: TradingColors.primary,
        primaryContainer: TradingColors.primaryLight,
        secondary: TradingColors.secondary,
        secondaryContainer: TradingColors.secondaryLight,
        surface: TradingColors.lightSurface,
        surfaceContainerHighest: TradingColors.surfaceLight,
        background: TradingColors.lightBackground,
        error: TradingColors.error,
        onPrimary: TradingColors.textPrimary,
        onSecondary: TradingColors.textPrimary,
        onSurface: TradingColors.lightText,
        onBackground: TradingColors.lightText,
        onError: TradingColors.textPrimary,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: TradingColors.lightSurface,
        foregroundColor: TradingColors.lightText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TradingTextStyles.titleLarge(
          color: TradingColors.lightText,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: TradingColors.lightSurface,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusMd),
        ),
        margin: const EdgeInsets.all(TradingSizes.sm),
      ),

      // Text Theme for Light Mode
      textTheme: TextTheme(
        displayLarge: TradingTextStyles.displayLarge(
          color: TradingColors.lightText,
        ),
        displayMedium: TradingTextStyles.displayMedium(
          color: TradingColors.lightText,
        ),
        displaySmall: TradingTextStyles.displaySmall(
          color: TradingColors.lightText,
        ),
        headlineLarge: TradingTextStyles.headlineLarge(
          color: TradingColors.lightText,
        ),
        headlineMedium: TradingTextStyles.headlineMedium(
          color: TradingColors.lightText,
        ),
        headlineSmall: TradingTextStyles.headlineSmall(
          color: TradingColors.lightText,
        ),
        titleLarge: TradingTextStyles.titleLarge(
          color: TradingColors.lightText,
        ),
        titleMedium: TradingTextStyles.titleMedium(
          color: TradingColors.lightText,
        ),
        titleSmall: TradingTextStyles.titleSmall(
          color: TradingColors.lightText,
        ),
        bodyLarge: TradingTextStyles.bodyLarge(color: TradingColors.lightText),
        bodyMedium: TradingTextStyles.bodyMedium(
          color: TradingColors.lightText,
        ),
        bodySmall: TradingTextStyles.bodySmall(color: TradingColors.lightText),
        labelLarge: TradingTextStyles.labelLarge(
          color: TradingColors.lightText,
        ),
        labelMedium: TradingTextStyles.labelMedium(
          color: TradingColors.lightText,
        ),
        labelSmall: TradingTextStyles.labelSmall(
          color: TradingColors.lightText,
        ),
      ),

      // Scaffold Background
      scaffoldBackgroundColor: TradingColors.lightBackground,
    );
  }
}
