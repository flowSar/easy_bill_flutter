
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> logIn(String username, String password) async {
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logOut(String username, String password) async {
    _isLoggedIn = false;
    notifyListeners();
  }

}