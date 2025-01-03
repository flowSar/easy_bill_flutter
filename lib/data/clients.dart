import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientRow {
  final String name;
  final String value;

  ClientRow({required this.name, required this.value});

  DropdownMenuItem getClient() {
    return DropdownMenuItem(
      child: Text(name),
      value: value,
    );
  }
}

List<DropdownMenuItem> clients = [
  ClientRow(name: 'khalid', value: 'khalid').getClient(),
  ClientRow(name: 'mohammed', value: 'mohammed').getClient(),
  ClientRow(name: 'yassine', value: 'yassine').getClient(),
  ClientRow(name: 'rachid', value: 'rachid').getClient(),
  ClientRow(name: 'ahmed', value: 'ahmed').getClient(),
  ClientRow(name: 'fatime', value: 'fatime').getClient(),
  ClientRow(name: 'idrisi', value: 'idrisi').getClient(),
  ClientRow(name: 'chtibi', value: 'chtibi').getClient(),
  ClientRow(name: 'othman', value: 'othman').getClient(),
  ClientRow(name: 'dahoh', value: 'dahoh').getClient(),
  ClientRow(name: 'said', value: 'said').getClient(),
  ClientRow(name: 'achraf', value: 'achraf').getClient(),
];
