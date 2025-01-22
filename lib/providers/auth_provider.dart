import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? userUid;

  AuthProvider() {
    _checkLoginStatus();
  }

  bool get isLoggedIn => _isLoggedIn;

  Future<void> _checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _isLoggedIn = true;
      userUid = user.uid;
    } else {
      _isLoggedIn = false;
      userUid = null;
    }
    notifyListeners();
  }

  Future<bool> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        _isLoggedIn = true;
      }
    } on FirebaseAuthException catch (e) {
      _isLoggedIn = false;
      if (e.code == 'email-already-in-use') {
        throw Exception('email-already-in-use');
      }
      throw Exception('Sign Up failed: $e');
    }
    notifyListeners();
    return _isLoggedIn;
  }

  Future<bool> logIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _isLoggedIn = true;
        userUid = user.uid;
      } else {}
    } on FirebaseAuthException catch (e) {
      _isLoggedIn = false;
      throw Exception('Sign In Failed ${e.code}');
    }
    notifyListeners();
    return _isLoggedIn;
  }

  Future<bool> logOut() async {
    await FirebaseAuth.instance.signOut();
    _isLoggedIn = false;
    userUid = null;
    notifyListeners();
    return _isLoggedIn;
  }

  void test() {
    notifyListeners();
  }
}
