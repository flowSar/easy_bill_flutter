class BusinessInfo {
  final String _businessName;
  final String? _businessAddress;
  final String? _businessEmail;
  final String? _businessPhoneNumber;

  BusinessInfo(
      {required businessName,
      businessAddress,
      businessEmail,
      businessPhoneNumber})
      : _businessName = businessName,
        _businessAddress = businessAddress,
        _businessEmail = businessEmail,
        _businessPhoneNumber = businessPhoneNumber;

  String get businessName => _businessName;

  String? get businessAddress => _businessAddress;

  String? get businessEmail => _businessEmail;

  String? get businessPhoneNumber => _businessPhoneNumber;

  Map<String, dynamic> toDic() {
    return {
      'businessName': _businessName,
      'businessAddress': _businessAddress,
      'businessEmail': _businessEmail,
      'businessPhoneNumber': _businessPhoneNumber
    };
  }
}
