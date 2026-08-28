import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _keyDarkMode = 'isDarkMode';

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_keyDarkMode) ?? false;
    notifyListeners();
  }

  Future<void> toggle() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, _isDarkMode);
  }
}
