import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? userUid;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> logIn(String username, String password) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _isLoggedIn = true;
      userUid = user.uid;
    }
    notifyListeners();
  }

  Future<void> logOut(String username, String password) async {
    _isLoggedIn = false;
    userUid = null;
    notifyListeners();
  }

  void test() {
    notifyListeners();
  }
}
