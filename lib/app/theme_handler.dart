import 'package:appearance/appearance.dart';
import 'package:flutter/material.dart';
import 'package:better_breaks/app/shared_preferences_manager.dart';

class AppThemeHandler extends StatefulWidget {
  final Widget child;

  const AppThemeHandler({
    required this.child,
    super.key,
  });

  @override
  State<AppThemeHandler> createState() => _AppThemeHandlerState();
}

class _AppThemeHandlerState extends State<AppThemeHandler> {
  late ThemeMode _currentThemeMode;

  @override
  void initState() {
    super.initState();
    // Get the saved theme mode from preferences
    _currentThemeMode = AppPreferenceManager.instance.getThemeModeEnum();
  }

  /// Convert ThemeMode to integer for storage
  int _getIntFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
      default:
        return 0; // System
    }
  }

  void _handleThemeModeChange(ThemeMode mode) {
    if (_currentThemeMode != mode) {
      setState(() {
        _currentThemeMode = mode;
      });
      // Save the new theme mode
      AppPreferenceManager.instance.saveThemeMode(_getIntFromThemeMode(mode));

      // Log for debugging
      debugPrint('Theme changed to: $mode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Appearance(
      mode: _currentThemeMode,
      setMode: _handleThemeModeChange,
      child: widget.child,
    );
  }
}

// Extension to provide easy theme switching access throughout the app
extension ThemeHelper on BuildContext {
  ThemeMode? get currentThemeMode => Appearance.of(this)?.mode;

  bool get isDarkMode {
    final mode = Appearance.of(this)?.mode;
    if (mode == ThemeMode.system) {
      return MediaQuery.of(this).platformBrightness == Brightness.dark;
    }
    return mode == ThemeMode.dark;
  }

  void setThemeMode(ThemeMode mode) {
    Appearance.of(this)?.setMode(mode);
  }
}
