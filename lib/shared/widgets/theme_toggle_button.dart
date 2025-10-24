import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';

/// Theme Toggle Button Widget
/// Provides a consistent theme switching button across the app
class ThemeToggleButton extends StatelessWidget {
  final bool showLabel;
  final Color? iconColor;
  final double? iconSize;

  const ThemeToggleButton({
    super.key,
    this.showLabel = false,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return showLabel
            ? ElevatedButton.icon(
                onPressed: () => themeProvider.toggleTheme(),
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  size: iconSize ?? 20,
                  color: iconColor,
                ),
                label: Text(
                  themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              )
            : IconButton(
                onPressed: () => themeProvider.toggleTheme(),
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  size: iconSize ?? 24,
                  color: iconColor,
                ),
                tooltip: themeProvider.isDarkMode
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
              );
      },
    );
  }
}

/// Theme Toggle Switch Widget
/// Alternative theme toggle using a switch
class ThemeToggleSwitch extends StatelessWidget {
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;

  const ThemeToggleSwitch({
    super.key,
    this.label,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null) ...[Text(label!), const SizedBox(width: 8)],
            Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.setTheme(value),
              activeColor: activeColor,
              inactiveThumbColor: inactiveColor,
            ),
            const SizedBox(width: 8),
            Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              size: 20,
            ),
          ],
        );
      },
    );
  }
}
