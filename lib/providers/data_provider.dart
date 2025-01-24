import 'dart:io';
import 'package:easy_bill_flutter/modules/bill.dart';
import 'package:easy_bill_flutter/modules/business_info.dart';
import 'package:easy_bill_flutter/modules/clients.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../modules/item.dart';

class DataProvider extends ChangeNotifier {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late List<Client> clients = [];
  late List<Item> items = [];
  late BusinessInfo? businessInfo;
  late List<Bill> bills = [];
  late List<Item> _tempItemsList = [];
  late List<Client> _tempClientsList = [];
  File? signature;

  DataProvider() {
    User? user = getCurrentUser();
    if (user != null) {
      // load all item building during the building gof the first screen or when the app get opened
      loadItemsData();
      loadClientsData();
      loadSignature();
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // this function will add new item to the database and load all data users/userId/items
  Future<void> addItem(Item item) async {
    final user = getCurrentUser();
    if (user != null) {
      try {
        DatabaseReference userRef = _database.ref('users/${user.uid}');
        await userRef.child('items/${item.barCode}/').update(item.toDic());
        await loadItemsData();
        notifyListeners();
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
            String tax = item['tax'] ?? '0';

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
                description: description,
                tax: tax,
              ),
            );
          }
          // make a copy of the items list to use it for filtering the list
          _tempItemsList = List.from(items);
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
          // make a copy of the clients list to use it for filtering the list
          _tempClientsList = List.from(clients);
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
        notifyListeners();
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
        if (snapshot.exists) {
          Map<String, dynamic> data =
              Map<String, dynamic>.from(snapshot.value as Map);
          businessInfo = BusinessInfo(
            businessName: data['businessName'],
            businessAddress: data['businessAddress'],
            businessEmail: data['businessEmail'],
            businessPhoneNumber: data['businessPhoneNumber'],
          );
          notifyListeners();
        } else {
          businessInfo = null;
          throw Exception('Nothing was found');
        }
      } catch (e) {
        businessInfo = null;
        throw Exception('load business info failed $e');
      }
    } else {
      businessInfo = null;
      throw Exception('user is not logged in');
    }
  }

  Future<void> addBill(Bill bill) async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        DatabaseReference databaseRef =
            _database.ref('users/${user.uid}/bills/${bill.id}');
        await databaseRef.update(bill.toDic());
        loadBills();
      } catch (e) {
        throw Exception('pushing bill to database failed: $e');
      }
    } else {
      throw Exception('user is not logged in');
    }
  }

  Future<void> loadBills() async {
    User? user = getCurrentUser();
    // initialize the bill with empty list etch will call this function to load data
    bills = [];
    if (user != null) {
      try {
        DatabaseReference dataBillsRef =
            _database.ref('users/${user.uid}/bills');

        DataSnapshot snapshot = await dataBillsRef.get();
        if (snapshot.exists) {
          Map<String, dynamic> billsData =
              Map<String, dynamic>.from(snapshot.value as Map);
          for (var entry in billsData.entries) {
            List<dynamic> rawItems = entry.value['items'] as List<dynamic>;
            List<Map<String, dynamic>> billItems = rawItems
                .map((item) => Map<String, dynamic>.from(item as Map))
                .toList();
            List<Map<String, dynamic>> billRows = [];
            for (var row in billItems) {
              billRows.add(BillRow(
                      id: 'null',
                      name: row['name'],
                      quantity: row['quantity'],
                      price: row['price'],
                      total: row['total'],
                      tax: row['tax'])
                  .toDic());
            }
            bills.add(Bill(
              id: entry.value['id'],
              clientName: entry.value['clientName'],
              billDate: entry.value['billDate'],
              items: billRows,
              total: entry.value['total'],
              clientEmail: entry.value['clientEmail'],
              clientPhoneNumber: entry.value['clientPhoneNumber'],
              billNumber: entry.value['billNumber'],
            ));
            // the bills length + 1 is the bill number of the new bill that will get created
          }
          notifyListeners();
        } else {
          throw Exception('Nothing was found ');
        }
      } catch (e) {
        throw Exception('loading billFailed $e ');
      }
      // print(bills);
    } else {
      throw Exception('user is not logged in');
    }
  }

  Future<void> deleteBill(String billId) async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        DatabaseReference dbRef =
            _database.ref('users/${user.uid}/bills/$billId');
        dbRef.remove();
        loadBills();
        notifyListeners();
      } catch (e) {
        throw Exception('deleting the bill has failed $e');
      }
    } else {
      throw Exception('user is ot logged in');
    }
  }

  void flitterLists(String name, String listName) {
    items = List.from(_tempItemsList);
    clients = List.from(_tempClientsList);
    if (listName == 'items') {
      if (items.isEmpty) {
        items = List.from(_tempItemsList);
      } else {
        items = items.where((item) => item.name.contains(name)).toList();
        notifyListeners();
      }
    } else if (listName == 'clients') {
      if (clients.isEmpty) {
        clients = List.from(_tempClientsList);
      } else {
        clients =
            clients.where((client) => client.fullName.contains(name)).toList();
        notifyListeners();
      }
    }
  }

  Future<void> addSignature(String url) async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        // Reference storageRef = _storage.ref('users/${user.uid}/signature');
        DatabaseReference dbRef = _database.ref('users/${user.uid}/');
        dbRef.child('signature/').set(url);
        notifyListeners();
      } catch (e) {
        throw Exception('failed signature $e');
      }
    }
  }

  Future<void> loadSignature() async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        // Reference storageRef = _storage.ref('users/${user.uid}/signature');
        DatabaseReference dbRef = _database.ref('users/${user.uid}/signature');
        DataSnapshot snapshot = await dbRef.get();
        if (snapshot.exists) {
          String filePath = snapshot.value.toString();
          File file = File(filePath);
          signature = file;
          notifyListeners();
        } else {
          throw Exception('file does not exist');
        }
      } catch (e) {
        throw Exception('failed signature $e');
      }
    } else {
      throw Exception('use is not logged in ');
    }
  }
}
