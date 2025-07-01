import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferenceManager {
  static final AppPreferenceManager _instance =
      AppPreferenceManager._internal();
  static AppPreferenceManager get instance => _instance;

  late SharedPreferences _prefs;

  AppPreferenceManager._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Theme related methods
  static const String _themeKey = 'app_theme_mode';

  Future<void> saveThemeMode(int mode) async {
    await _prefs.setInt(_themeKey, mode);
  }

  int getThemeMode() {
    return _prefs.getInt(_themeKey) ?? 0; // 0 = system, 1 = light, 2 = dark
  }

  ThemeMode getThemeModeEnum() {
    final value = getThemeMode();
    switch (value) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
