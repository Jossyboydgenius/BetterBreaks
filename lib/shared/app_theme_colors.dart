import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';

/// Theme-aware colors that adapt based on the current theme mode
class AppThemeColors {
  /// Get the appropriate background color based on the current brightness
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : AppColors.backgroundDark;
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
}
