import 'package:flutter/material.dart';

/// Trading UI Kit Size System
/// Provides consistent sizing for trading applications
class TradingSizes {
  // Private constructor to prevent instantiation
  TradingSizes._();

  // Spacing System (8px base unit)
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 24.0;
  static const double radiusRound = 50.0;

  // Icon Sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 20.0;
  static const double iconLg = 24.0;
  static const double iconXl = 32.0;
  static const double iconXxl = 48.0;

  // Button Heights
  static const double buttonHeightSm = 32.0;
  static const double buttonHeightMd = 40.0;
  static const double buttonHeightLg = 48.0;
  static const double buttonHeightXl = 56.0;

  // Input Heights
  static const double inputHeightSm = 36.0;
  static const double inputHeightMd = 44.0;
  static const double inputHeightLg = 52.0;

  // Card Dimensions
  static const double cardMinHeight = 80.0;
  static const double cardMaxHeight = 200.0;
  static const double cardPadding = 16.0;

  // Chart Dimensions
  static const double chartMinHeight = 200.0;
  static const double chartMaxHeight = 400.0;
  static const double chartPadding = 16.0;

  // Trading Widget Sizes
  static const double orderBookRowHeight = 32.0;
  static const double priceListRowHeight = 40.0;
  static const double tradeHistoryRowHeight = 36.0;
  static const double portfolioItemHeight = 60.0;

  // Screen Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;

  // App Bar Heights
  static const double appBarHeight = 56.0;
  static const double appBarHeightLarge = 64.0;

  // Bottom Navigation
  static const double bottomNavHeight = 60.0;
  static const double bottomNavHeightLarge = 80.0;

  // Sidebar Widths
  static const double sidebarWidth = 280.0;
  static const double sidebarWidthCollapsed = 60.0;

  // Trading Panel Sizes
  static const double tradingPanelHeight = 300.0;
  static const double orderPanelWidth = 320.0;
  static const double chartPanelMinHeight = 400.0;

  // Responsive Sizes
  static double getResponsiveSize(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width >= TradingSizes.desktopBreakpoint) {
      return desktop;
    } else if (width >= TradingSizes.tabletBreakpoint) {
      return tablet;
    } else {
      return mobile;
    }
  }

  // Spacing Helpers
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  static const EdgeInsets paddingHorizontalXs = EdgeInsets.symmetric(
    horizontal: xs,
  );
  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(
    horizontal: sm,
  );
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(
    horizontal: md,
  );
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(
    horizontal: lg,
  );

  static const EdgeInsets paddingVerticalXs = EdgeInsets.symmetric(
    vertical: xs,
  );
  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(
    vertical: sm,
  );
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(
    vertical: md,
  );
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(
    vertical: lg,
  );
}
