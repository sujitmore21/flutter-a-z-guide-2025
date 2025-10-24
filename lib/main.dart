import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui_kit/theme/trading_theme.dart';
import 'features/dashboard/presentation/pages/dashboard_screen.dart';
import 'examples/comprehensive_ui_examples.dart';
import 'core/providers/theme_provider.dart';

void main() {
  runApp(const TradingApp());
}

/// Trading App
/// Main application entry point for the Flutter Trading UI Kit
class TradingApp extends StatelessWidget {
  const TradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Trading UI Kit',
            debugShowCheckedModeBanner: false,
            theme: TradingTheme.lightTheme,
            darkTheme: TradingTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const MainNavigationScreen(),
          );
        },
      ),
    );
  }
}

/// Main Navigation Screen with Bottom Navigation Bar
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ComprehensiveUIExamples(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      appBar: AppBar(
        title: const Text('Flutter UI Kit'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                onPressed: () => themeProvider.toggleTheme(),
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                tooltip: themeProvider.isDarkMode
                    ? 'Switch to Light'
                    : 'Switch to Dark',
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'UI Kit'),
        ],
      ),
    );
  }
}
