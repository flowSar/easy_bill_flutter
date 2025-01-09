import 'package:easy_bill_flutter/components/bill_card.dart';
import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/custom_modal_Bottom_sheet.dart';
import 'package:easy_bill_flutter/components/custom_popup_menu_button.dart';
import 'package:easy_bill_flutter/components/empty.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:easy_bill_flutter/services/database_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/bill.dart';
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
    loadBills();
    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    super.dispose();
  }

  Future loadBills() async {
    try {
      setState(() {
        loading = true;
      });
      await context.read<DataProvider>().loadBills();
      loading = false;
    } catch (e) {
      print('error: $e');
      setState(() {
        loading = false;
      });
    }
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
        List<Bill> bills = dataProvider.bills;
        if (loading) {
          return Center(
            child: CustomCircularProgress(
              w: 120,
              h: 120,
              strokeWidth: 4,
            ),
          );
        } else {
          if (bills.isNotEmpty) {
            return ListView.builder(
              itemCount: bills.length,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.push('/previewBillScreen', extra: bills[index]);
                    print('select bill');
                  },
                  child: BillCard(
                      client: bills[index].clientName,
                      date: bills[index].billDate,
                      billNumber: (index + 1).toString(),
                      total: bills[index].total),
                );
              },
            );
          } else {
            return Center(
                child: Empty(title: 'No bill/invoice Was found', subTitle: ''));
          }
        }
      }),
    ));
  }
}
