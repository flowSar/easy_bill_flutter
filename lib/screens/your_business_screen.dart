import 'package:easy_bill_flutter/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class YourBusinessScreen extends StatefulWidget {
  const YourBusinessScreen({super.key});

  @override
  State<YourBusinessScreen> createState() => _YourBusinessScreenState();
}

class _YourBusinessScreenState extends State<YourBusinessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomTextField(),
              CustomTextField(),
              CustomTextField(),
              CustomTextField(),
            ],
          ),
        ),
      ),
    ));
  }
}
