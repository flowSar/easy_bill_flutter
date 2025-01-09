import 'package:easy_bill_flutter/components/bill_card.dart';
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
  bool loading = false;

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
      appBar: AppBar(
        title: Text(
          'Bills',
          textAlign: TextAlign.center,
        ),
        leading: Icon(null),
      ),
      body: Consumer<DataProvider>(builder: (context, dataProvider, child) {
        if (loading) {
          return Center(
            child: CustomCircularProgress(),
          );
        } else {
          return ListView.builder(
            itemCount: 6,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('select bill');
                },
                child: BillCard(
                    client: 'khalid',
                    date: '09/01/2025',
                    billNumber: '1',
                    total: '1400'),
              );
            },
          );
        }
      }),
    ));
  }
}
