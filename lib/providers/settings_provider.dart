import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  late String _currency;

  SettingsProvider() {
    _currency = 'dh';
  }

  String get currency => _currency;

  void setCurrency(String newCurrency) {
    _currency = newCurrency;
    notifyListeners();
  }
}
