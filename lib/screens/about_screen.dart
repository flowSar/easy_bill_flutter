import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:easy_bill_flutter/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  List<String> names = [
    'khalid',
    'mohammed',
    'yassine',
    'adil',
    'rachid',
    'saad',
    'said',
    'fatima',
    'malika'
  ];

  List<String> originalList = [
    'khalid',
    'mohammed',
    'yassine',
    'adil',
    'rachid',
    'saad',
    'said',
    'fatima',
    'malika'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          CustomTextField(
            placeholder: 'Enter name',
            onChnaged: (value) {
              names = List.from(originalList);
              setState(() {
                names = names.where((name) => name.contains(value)).toList();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  names[index],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          CustomTextButton(
            onPressed: () {},
            label: Text('search'),
            bg: Colors.green,
            fg: Colors.white,
          ),
        ],
      ),
    ));
  }
}
