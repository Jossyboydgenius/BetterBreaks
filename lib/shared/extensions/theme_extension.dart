import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';

/// Extension methods for theme-aware colors
extension ThemeExtension on BuildContext {
  /// Get the current theme mode (light or dark)
  ThemeMode get themeMode {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  }

  /// Whether the current theme is dark
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  /// Get background color based on current theme
  Color get backgroundColor =>
      isDarkTheme ? AppColors.backgroundDark : AppColors.background;

  /// Get text color based on current theme
  Color get textColor => isDarkTheme ? Colors.white : AppColors.lightBlack;

  /// Get card color based on current theme
  Color get cardColor => isDarkTheme ? AppColors.lightBlack : Colors.white;

  /// Get divider color based on current theme
  Color get dividerColor =>
      isDarkTheme ? AppColors.grey600.withOpacity(0.5) : AppColors.grey200;

  /// Get icon color based on current theme
  Color get iconColor => isDarkTheme ? Colors.white70 : AppColors.grey600;
}
