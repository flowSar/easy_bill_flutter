import 'package:easy_bill_flutter/screens/clients/clients_screen.dart';
import 'package:easy_bill_flutter/screens/items/items_screen.dart';
import 'package:easy_bill_flutter/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bills/bills_screen.dart';
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
                FontAwesomeIcons.fileInvoice,
              ),
              label: 'Bills'),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.users,
              ),
              label: 'Clients'),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.list,
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
