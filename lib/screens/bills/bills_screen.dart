import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/custom_modal_Bottom_sheet.dart';
import 'package:easy_bill_flutter/components/custom_popup_menu_button.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:easy_bill_flutter/services/database_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/item.dart';

final _formKey = GlobalKey<FormState>();

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  late TextEditingController _userName;

  @override
  void initState() {
    _userName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _userName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (name) => name!.length < 3 ? 'Please ' : null,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await context.read<DataProvider>().loadClientsData();
              print(context.read<DataProvider>().clients[0].fullName);
              // List<Item> items = context.read<DataProvider>().items;
              // for (var item in items) {
              //   print(item.name);
              // }
              // _formKey.currentState!.validate();
              // FireBaseManager firebaseManager = FireBaseManager();
              // DataSnapshot result = await firebaseManager.loadItemsData();
              // Map<Object?, Object?> data =
              //     result.value as Map<Object?, Object?>;
              // for (var row in data.entries) {
              //   Map<Object?, Object?> user = row.value as Map<Object?, Object?>;
              //   print(user);
              // }
              //
              // print('result end');
            },
            child: Text('Save'),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomModalBottomSheet();
                  });
            },
            child: Text('Open Bottom Sheet'),
          ),
        ],
      )),
    );
  }
}
