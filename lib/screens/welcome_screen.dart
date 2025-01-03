import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            Text(
              'Welcome to EasyBill',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
            ),
            Text(
              'With EasyBill, you can manage and browse your market bills anytime, anywhere, across multiple devices.',
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
