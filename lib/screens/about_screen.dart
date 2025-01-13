import 'package:easy_bill_flutter/components/currency_dialog.dart';
import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:easy_bill_flutter/components/custom_text_field.dart';
import 'package:easy_bill_flutter/components/error_dialog.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
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
  late final TextEditingController _username;

  @override
  void initState() {
    // TODO: implement initState
    _username = TextEditingController();
    super.initState();
  }

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
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isSwitched ? 1.0 : 0.0,
              child: Text(
                'Enter your text',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ),
            CustomTextButton(
                onPressed: () async {
                  final result = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 10),
                          title: Text('Helo'),
                          content: SizedBox(
                            height: 440,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CustomTextField(
                                    bg: Colors.redAccent[100],
                                  ),
                                  CustomTextField(
                                    bg: Colors.redAccent[100],
                                  ),
                                  CustomTextField(
                                    bg: Colors.redAccent[100],
                                  ),
                                  CustomTextField(
                                    bg: Colors.redAccent[100],
                                  ),
                                  CustomTextField(
                                    bg: Colors.redAccent[100],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                  print('result: $result');
                },
                label: Text('show DIlog'),
                bg: Colors.redAccent,
                fg: Colors.white),
            CustomTextButton(
                onPressed: () {},
                label: Text('modal'),
                bg: Colors.blue,
                fg: Colors.white)
          ],
        ),
      ),
    ));
  }
}
