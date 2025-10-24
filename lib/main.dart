import 'package:flutter/material.dart';
import 'ui_kit/theme/trading_theme.dart';
import 'features/dashboard/presentation/pages/dashboard_screen.dart';

void main() {
  runApp(const TradingApp());
}

/// Trading App
/// Main application entry point for the Flutter Trading UI Kit
class TradingApp extends StatelessWidget {
  const TradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Trading UI Kit',
      debugShowCheckedModeBanner: false,
      theme: TradingTheme.darkTheme,
      home: const DashboardScreen(),
    );
  }
}
