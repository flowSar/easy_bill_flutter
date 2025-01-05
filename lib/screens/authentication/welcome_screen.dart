import 'package:easy_bill_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('images/EasyBill.webp')),
            Text(
              'With EasyBill, you can manage and browse your bills/invoices anytime, anywhere, across multiple devices.',
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/signIn');
              },
              child: Text('Get started'),
            ),
          ],
        ),
      ),
    ));
  }
}
