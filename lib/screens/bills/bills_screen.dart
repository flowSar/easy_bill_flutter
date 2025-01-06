import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/custom_modal_Bottom_sheet.dart';
import 'package:easy_bill_flutter/components/custom_popup_menu_button.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (name) => name!.length < 3 ? 'Please ' : null,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _formKey.currentState!.validate();
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
