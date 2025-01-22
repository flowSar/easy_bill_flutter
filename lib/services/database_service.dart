import 'package:easy_bill_flutter/modules/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireBaseManager {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> signUp(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? newUser = userCredential.user;
      return newUser;
    } catch (e) {
      return null;
    }
  }

  bool isLogged() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> addData(String userName) async {
    final user = getCurrentUser();

    if (user != null) {
      DatabaseReference userRef = _database.ref('users/${user.uid}');
      await userRef.set({
        'username': userName,
        'business-name': 'Achkid',
        'products': {
          'productName': 'jibal',
          'price': 12.5,
          'quantity': 23,
          'total': '287.5.',
        }
      });
    } else {
      throw Exception('user not logged in');
    }
  }

  Future<void> addItem(Item item) async {
    final user = getCurrentUser();
    if (user != null) {
      try {
        DatabaseReference userRef = _database.ref('users/${user.uid}');
        await userRef.child('items/${item.barCode}/').set(item.toDic());
      } catch (e) {
        throw Exception('failed inserting Item to the database: $e');
      }
    } else {
      throw Exception('user not logged in');
    }
  }

  Future<DataSnapshot> loadItemsData() async {
    final User? user = getCurrentUser();
    if (user != null) {
      DatabaseReference userRef = _database.ref('users/${user.uid}');
      return await userRef.child('items/').get();
    } else {
      throw Exception('user is not logged in');
    }
  }
}
