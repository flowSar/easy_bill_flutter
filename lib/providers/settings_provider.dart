import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  late String _currency;
  bool _isDarkMode = false;

  SettingsProvider() {
    _currency = 'dh';
  }

  String get currency => _currency;

  bool get isDarMode => _isDarkMode;

  void setCurrency(String newCurrency) {
    _currency = newCurrency;
    notifyListeners();
  }

  Future setDarkMode(bool state) async {
    _isDarkMode = state;
    notifyListeners();
  }
}
