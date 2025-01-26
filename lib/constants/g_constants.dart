import 'package:flutter/material.dart';

const kKeyEmailType = TextInputType.emailAddress;
const kKeyTextType = TextInputType.text;
const kKeyPhoneType = TextInputType.phone;
const kKeyNumberType = TextInputType.number;
const maxW = double.infinity;

enum ScreenMode {
  select, // select from the screen
  navigate, // navigate to the screen
}
