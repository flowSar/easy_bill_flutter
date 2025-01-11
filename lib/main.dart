import 'package:easy_bill_flutter/providers/auth_provider.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:easy_bill_flutter/providers/settings_provider.dart';
import 'package:easy_bill_flutter/rounters/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(ChangeNotifierProvider(
  //   create: (context) => AuthProvider(),
  //   child: MyApp(),
  // ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => DataProvider()),
      ChangeNotifierProvider(create: (_) => SettingsProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // theme: ThemeData.dark(),
      routerConfig: appRouter,
    );
  }
}
