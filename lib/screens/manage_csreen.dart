import 'package:flutter/material.dart';
class ManageCsreen extends StatefulWidget {
  const ManageCsreen({super.key});

  @override
  State<ManageCsreen> createState() => _ManageCsreenState();
}

class _ManageCsreenState extends State<ManageCsreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('manage'),
      ),
    );
  }
}
