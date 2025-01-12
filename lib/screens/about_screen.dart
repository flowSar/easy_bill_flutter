import 'package:easy_bill_flutter/components/currency_dialog.dart';
import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:easy_bill_flutter/components/custom_text_field.dart';
import 'package:easy_bill_flutter/components/error_dialog.dart';
import 'package:easy_bill_flutter/data/currency.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data_provider.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

List<String> options = ['option 1', 'option 2'];

class _AboutScreenState extends State<AboutScreen> {
  String selectedCurrency = 'US\$';
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextButton(onPressed: () {}, child: Text('click')),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value; // Update the state
                });
              },
            ),
          ],
        ),
      ),
    ));
  }
}
