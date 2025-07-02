import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';

/// Theme-aware colors that adapt based on the current theme mode
class AppThemeColors {
  /// Get the appropriate background color based on the current brightness
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.background
        : AppColors.backgroundDark;
  }

  /// Get the appropriate scaffold background color based on the current brightness
  static Color getScaffoldBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.background
        : AppColors.backgroundDark;
  }

  /// Get the appropriate container background color based on the current brightness
  static Color getContainerBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : AppColors.lightBlack;
  }

  /// Get the appropriate text color based on the current brightness
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.lightBlack
        : Colors.white;
  }

  /// Get the appropriate card color based on the current brightness
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : AppColors.lightBlack;
  }

  /// Get the appropriate card background color based on the current brightness
  static Color getCardBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : AppColors.grey800;
  }

  /// Get the appropriate divider color based on the current brightness
  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.grey200
        : AppColors.grey600;
  }

  /// Get shadow color appropriate for the current theme
  static Color getShadowColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.black.withOpacity(0.1)
        : Colors.black.withOpacity(0.3);
  }

  /// Get the appropriate icon color based on the current brightness
  static Color getIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.grey600
        : Colors.white70;
  }

  /// Get the appropriate drag handle color based on the current brightness
  static Color getDragHandleColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade300
        : Colors.grey.shade600;
  }

  /// Get the appropriate hint text color based on the current brightness
  static Color getHintTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.grey500
        : Colors.grey.shade400;
  }

  /// Get secondary text color based on the current brightness
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.grey700
        : Colors.grey.shade300;
  }

  /// Get the appropriate bottom navigation background color based on the current brightness
  static Color getBottomNavColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.lightPrimary
        : AppColors.backgroundDark.withOpacity(0.8);
  }

  /// Extension method to quickly get themed background color
  static Color background(BuildContext context) => getBackgroundColor(context);

  /// Extension method to quickly get themed text color
  static Color text(BuildContext context) => getTextColor(context);
}
