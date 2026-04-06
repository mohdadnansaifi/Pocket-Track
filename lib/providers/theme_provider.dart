import 'package:flutter/material.dart';
import '../services/prefs.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() {
    final saved = PrefsService.getThemeMode();

    if (saved == 'light') {
      _themeMode = ThemeMode.light;
    } else if (saved == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;

    // save as string
    if (mode == ThemeMode.light) {
      PrefsService.saveThemeMode('light');
    } else if (mode == ThemeMode.dark) {
      PrefsService.saveThemeMode('dark');
    } else {
      PrefsService.saveThemeMode('system');
    }

    notifyListeners();
  }
}