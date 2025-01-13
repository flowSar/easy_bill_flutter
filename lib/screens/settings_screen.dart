import 'package:easy_bill_flutter/components/select_card.dart';
import 'package:easy_bill_flutter/components/text_card.dart';
import 'package:easy_bill_flutter/providers/auth_provider.dart';
import 'package:easy_bill_flutter/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/currency_dialog.dart';
import '../components/select_item_button.dart';
import '../constants/colors.dart';
import '../data/currency.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = true;
  String selectedCurrency = '\$';
  late bool _isSwitched;

  @override
  void initState() {
    _isSwitched = context.read<SettingsProvider>().isDarMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Settings')),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Account & business',
                  style:
                      TextStyle(color: Colors.greenAccent[700], fontSize: 20),
                ),
              ),
              SelectCard(
                onTap: () async {
                  context.push('/businessScreen');
                },
                leftIcon: Icons.add,
                middleText: 'Your Business',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
              SelectCard(
                onTap: () async {
                  context.push('/aboutScreen');
                },
                leftIcon: Icons.info_outline,
                middleText: 'About',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
              SelectCard(
                onTap: () async {
                  final bool isLogged =
                      await context.read<AuthProvider>().logOut();
                  if (!isLogged) {
                    context.replace('/signIn');
                  }
                },
                leftIcon: Icons.logout,
                middleText: 'LogOut',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'general',
                  style:
                      TextStyle(color: Colors.greenAccent[700], fontSize: 20),
                ),
              ),
              SelectCard(
                onTap: () {},
                leftIcon: Icons.nightlight,
                middleText: 'Night Mode',
                p: 11,
                rightIcon: Switch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                      context.read<SettingsProvider>().setDarkMode(value);
                    });
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
              SelectCard(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CurrencyDialog());
                },
                leftIcon: Icons.currency_exchange,
                middleText: 'Currency ($selectedCurrency)',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
              SelectCard(
                onTap: () {
                  context.push('/signatureScreen');
                },
                leftIcon: Icons.padding_sharp,
                middleText: 'Signature',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
