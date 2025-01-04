import 'package:easy_bill_flutter/screens/clients/clients_screen.dart';
import 'package:easy_bill_flutter/screens/items/items_screen.dart';
import 'package:easy_bill_flutter/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import 'bills/bills_screen.dart';
import 'manage_screen.dart';
import 'bills/new_bill_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _screenIndex = 0;
  final List<Widget> screens = [
    NewBillScreen(),
    BillsScreen(),
    ClientsScreen(),
    ItemsScreen(),
    SettingsScreen(),
  ];

  void _handleItemTaped(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screenIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: _handleItemTaped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.create,
              ),
              label: 'New Bill'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.manage_history,
              ),
              label: 'Bills'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.supervisor_account_outlined,
              ),
              label: 'Clients'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_shopping_cart_rounded,
              ),
              label: 'Items'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Settings'),
        ],
      ),
    );
  }
}
