import 'package:flutter/material.dart';

const kKeyEmailType = TextInputType.emailAddress;
const kKeyTextType = TextInputType.text;
const kKeyPhoneType = TextInputType.phone;
const kKeyNumberType = TextInputType.number;
const maxW = double.infinity;

// we're using this ScreenMode: is if the screen for navigation or for selecting item from the screen
// with this mode we defined what type of action we trigger when any item of widget inside the screen clicked
enum ScreenMode {
  select, // select from the screen
  navigate, // navigate to the screen
}
