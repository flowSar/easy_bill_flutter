import 'package:firebase_auth/firebase_auth.dart';

class FireBaseManager {
  Future<dynamic> signUp(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? newUser = userCredential.user;
      return newUser;
    } catch (e) {
      print('error: $e');
      return null;
    }
  }
}
