import 'package:flutter/material.dart';

bool isValidNumber(String str) {
  int? number = int.tryParse(str);
  if (number != null) {
    return true;
  }
  return false;
}

// function for validating the Email
bool isEmailValid(String email) {
  // Regular expression to validate email addresses
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

// snack bar widget
snackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 1000),
    ),
  );
}
