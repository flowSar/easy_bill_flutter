import 'package:easy_bill_flutter/providers/auth_provider.dart';
import 'package:easy_bill_flutter/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/sign_in.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: SignIn(),
      )),
    );
  }
}
