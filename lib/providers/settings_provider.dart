import 'package:flutter/material.dart';
import 'package:async_preferences/async_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  late String _currency;
  bool _isDarkMode = false;
  final preferences = AsyncPreferences();

  SettingsProvider() {
    updateThemeState();
    _currency = 'dh';
  }

  void updateThemeState() async {
    try {
      bool? result = await preferences.getBool('isDark');
      if (result == true) {
        _isDarkMode = true;
      }
    } catch (e) {
      throw Exception('dark theme is not found $e');
    }
  }

  String get currency => _currency;

  bool get isDarMode => _isDarkMode;

  void setCurrency(String newCurrency) {
    _currency = newCurrency;
    notifyListeners();
  }

  Future setDarkMode(bool state) async {
    _isDarkMode = state;
    preferences.setBool('isDark', value: _isDarkMode);
    notifyListeners();
  }
}
