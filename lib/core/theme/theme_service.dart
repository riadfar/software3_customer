import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ValueNotifier<ThemeMode> {
  static const String _themeKey = 'theme_mode';
  final SharedPreferences _prefs;
  bool _isInitialized = false;

  ThemeService(this._prefs) : super(ThemeMode.system);

  /// Initialize and load theme from SharedPreferences
  Future<void> init() async {
    if (_isInitialized) return;
    try {
      final themeString = _prefs.getString(_themeKey);
      if (themeString != null) {
        value = _themeModeFromString(themeString);
      }
      _isInitialized = true;
    } catch (e) {
      // If loading fails, use system default
      value = ThemeMode.system;
      _isInitialized = true;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      value = mode;
      await _prefs.setString(_themeKey, _themeModeToString(mode));
    } catch (e) {
      // If saving fails, at least update the value for current session
      value = mode;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  String getThemeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'فاتح';
      case ThemeMode.dark:
        return 'داكن';
      case ThemeMode.system:
        return 'تلقائي';
    }
  }
}

