import 'package:easy_bill_flutter/data/business_info.dart';
import 'package:easy_bill_flutter/data/clients.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../data/item.dart';

class DataProvider extends ChangeNotifier {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late List<Client> clients = [];
  late List<Item> items = [];
  late BusinessInfo? businessInfo;

  DataProvider() {
    User? user = getCurrentUser();
    if (user != null) {
      // load all item building during the building gof the first screen or when the app get opened
      loadItemsData();
      loadClientsData();
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> addData(String userName) async {
    final user = getCurrentUser();

    if (user != null) {
      DatabaseReference userRef = _database.ref('users/${user.uid}');
    } else {
      throw Exception('user not logged in');
    }
  }

  // this function will add new item to the database and load all data users/userId/items
  Future<void> addItem(Item item) async {
    final user = getCurrentUser();
    if (user != null) {
      try {
        DatabaseReference userRef = _database.ref('users/${user.uid}');
        await userRef.child('items/${item.barCode}/').set(item.toDic());
        await loadItemsData();
      } catch (e) {
        throw Exception('failed inserting Item to the database: $e');
      }
    } else {
      throw Exception('user not logged in');
    }
  }

  Future<void> updateItem() async {}

  Future<void> deleteItem(String codeBar) async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        DatabaseReference clientRef =
            _database.ref('users/${user.uid}/items/$codeBar');
        await clientRef.remove();
        await loadItemsData();
      } catch (e) {
        throw Exception('removing failed of item barCode: $codeBar');
      }
    } else {
      throw Exception('user is not logged');
    }
  }

  // load all item from database
  Future<void> loadItemsData() async {
    final User? user = getCurrentUser();
    items = [];
    if (user != null) {
      try {
        DatabaseReference userRef = _database.ref('users/${user.uid}');
        DataSnapshot rawData = await userRef.child('items/').get();

        if (rawData.exists) {
          Map<String, dynamic> data =
              Map<String, dynamic>.from(rawData.value as Map);

          for (var row in data.entries) {
            Map<String, dynamic> item = Map<String, dynamic>.from(row.value);

            String name = item['name'] ?? '';
            String barCode = item['barCode'] ?? '';
            String description = item['description'] ?? '';

            double price = 0.0;
            int quantity = 0;
            if (item['price'] != null) {
              price = double.tryParse(item['price'].toString()) ?? 0.0;
            }
            if (item['quantity'] != null) {
              quantity = int.tryParse(item['quantity'].toString()) ?? 0;
            }

            items.add(
              Item(
                  barCode: barCode,
                  name: name,
                  price: price,
                  quantity: quantity,
                  description: description),
            );
          }
          notifyListeners();
        } else {
          throw Exception('No items found');
        }
      } catch (e) {
        notifyListeners();
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<void> loadClientsData() async {
    final User? user = getCurrentUser();
    clients = [];
    if (user != null) {
      try {
        DatabaseReference userRef = _database.ref('users/${user.uid}');
        DataSnapshot rawData = await userRef.child('clients/').get();

        if (rawData.exists) {
          Map<String, dynamic> data =
              Map<String, dynamic>.from(rawData.value as Map);

          for (var row in data.entries) {
            Map<String, dynamic> client = Map<String, dynamic>.from(row.value);
            String? clientId = client['clientId'];
            String? fullName = client['fullName'];
            String? address = client['address'];
            String? email = client['email'];
            String? phoneNumber = client['phoneNumber'];

            clients.add(
              Client(
                  clientId: clientId,
                  fullName: fullName,
                  email: email,
                  address: address,
                  phoNumber: phoneNumber),
            );
          }
          notifyListeners();
        } else {
          throw Exception('Nothing was found');
        }
      } catch (e) {
        notifyListeners();
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  // add new client to the database users/userId/clients
  Future<void> addClients(Client client) async {
    User? user = getCurrentUser();
    if (user != null) {
      DatabaseReference dataRef = _database.ref('users/${user.uid}');
      try {
        await dataRef
            .child('clients/${client.clientId}/')
            .update(client.toDic());
        await loadClientsData();
      } catch (e) {
        throw Exception('adding New client Failed');
      }
    } else {
      throw Exception('user is not logged in');
    }
  }

  Future<void> deleteClient(String clientId) async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        DatabaseReference clientRef =
            _database.ref('users/${user.uid}/clients/$clientId');
        await clientRef.remove();
      } catch (e) {
        throw Exception('removing failed of client id: $clientId');
      } finally {
        await loadClientsData();
      }
    } else {
      throw Exception('user is not logged');
    }
  }

  Future<void> addBusinessInfo(BusinessInfo businessInfo) async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        DatabaseReference businessRef =
            _database.ref('users/${user.uid}/business');
        await businessRef.update(businessInfo.toDic());
        loadBusinessInfo();
      } catch (e) {
        throw Exception('insert business info failed');
      }
    } else {
      throw Exception('user is not logged in');
    }
  }

  Future<void> loadBusinessInfo() async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        DatabaseReference businessRef =
            _database.ref('users/${user.uid}/business');
        DataSnapshot snapshot = await businessRef.get();
        Map<String, dynamic> data =
            Map<String, dynamic>.from(snapshot.value as Map);
        businessInfo = BusinessInfo(
          businessName: data['businessName'],
          businessAddress: data['businessAddress'],
          businessEmail: data['businessEmail'],
          businessPhoneNumber: data['businessPhoneNumber'],
        );
        notifyListeners();
      } catch (e) {
        throw Exception('load business info failed $e');
      }
    } else {
      throw Exception('user is not logged in');
    }
  }
}
