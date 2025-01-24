import 'package:flutter/material.dart';
import 'package:async_preferences/async_preferences.dart';

final preferences = AsyncPreferences();

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

List<String> options = ['option 1', 'option 2'];

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Image.asset(
              'images/EasyBill.png',
              width: 200,
            ),
            Text('version 1.0.0'),
            Text(
              'EasyBill is a powerful app designed to streamline the billing and invoicing process',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ));
  }
}
