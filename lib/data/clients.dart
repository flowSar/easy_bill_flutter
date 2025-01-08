class Client {
  final String _clientId;
  final String _fullName;
  final String _address;
  final String _email;
  final String _phoneNumber;

  Client({required clientId, required fullName, address, email, phoNumber})
      : _clientId = clientId,
        _fullName = fullName,
        _address = address,
        _email = email,
        _phoneNumber = phoNumber;

  String get clientId => _clientId;

  String get fullName => _fullName;

  String get address => _address;

  String get email => _email;

  String get phoneNumber => _phoneNumber;

  Map<String, dynamic> toDic() {
    return {
      'clientId': _clientId,
      'fullName': _fullName,
      'address': _address,
      'email': _email,
      'phoneNumber': _phoneNumber,
    };
  }
}
