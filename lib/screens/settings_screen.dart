import 'package:easy_bill_flutter/components/text_card.dart';
import 'package:easy_bill_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/select_item_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SelectItemButton(
              label: 'Your Business',
              elevation: 0,
              onPressed: () {
                context.push('/businessScreen');
              },
            ),
            InkWell(
              onTap: () async {
                final bool isLogged =
                    await context.read<AuthProvider>().logOut();
                if (!isLogged) {
                  context.replace('/signIn');
                }
              },
              child: TextCard(
                bg: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text('LogOut'),
                    Icon(Icons.logout),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                context.push('/aboutScreen');
              },
              child: TextCard(
                bg: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text('About'),
                    Icon(Icons.info_outline),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
