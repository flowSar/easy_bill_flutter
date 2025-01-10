bool isValidNumber(String str) {
  int? number = int.tryParse(str);
  if (number != null) {
    return true;
  }
  return false;
}

bool isEmailValid(String email) {
  // Regular expression to validate email addresses
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}
