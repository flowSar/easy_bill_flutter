import 'package:flutter/material.dart';

import 'history_screen.dart';
import 'manage_csreen.dart';
import 'new_bill_screen.dart';
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _screenIndex = 0;
  final List<Widget> screens = [
    NewBillScreen(),
    HistoryScreen(),
    ManageCsreen(),
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
        onTap: _handleItemTaped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.create,), label: 'New Bill'),
          BottomNavigationBarItem(icon: Icon(Icons.manage_history,), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings,), label: 'Manage'),
        ],
      ),
    );
  }
}
