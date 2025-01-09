import 'package:easy_bill_flutter/screens/bills/bills_screen.dart';

class BillRow {
  final String _id;
  final String _name;
  final String _quantity;
  final String _price;
  final String _tax;
  final String _total;

  BillRow(
      {required id,
      required name,
      required quantity,
      required price,
      required total,
      required tax})
      : _name = name,
        _id = id,
        _quantity = quantity,
        _price = price,
        _tax = tax,
        _total = total;

  String get name => _name;

  String get id => _id;

  String get quantity => _quantity;

  String get price => _price;

  String get tax => _tax;

  String get total => _total;

  Map<String, dynamic> toDic() {
    return {
      'name': _name,
      'quantity': _quantity,
      'price': _price,
      'tax': _tax,
      'total': _total,
    };
  }
}

class Bill {
  final String _id;
  final String _clientName;
  final String _clientEmail;
  final String _clientPhoneNumber;
  final String _billDate;
  final String _total;
  final List<Map<String, dynamic>> _items;

  Bill({
    required id,
    required clientName,
    required billDate,
    required items,
    required total,
    required clientEmail,
    required clientPhoneNumber,
  })  : _id = id,
        _clientName = clientName,
        _billDate = billDate,
        _items = items,
        _total = total,
        _clientEmail = clientEmail,
        _clientPhoneNumber = clientPhoneNumber;

  String get clientName => _clientName;

  String get id => _id;

  String get billDate => _billDate;

  String get total => _total;

  String get clientEmail => _clientEmail;

  String get clientPhoneNumber => _clientPhoneNumber;

  List<Map<String, dynamic>> get items => _items;

  Map<String, dynamic> toDic() {
    return {
      'id': _id,
      'clientName': _clientName,
      'billDate': _billDate,
      'total': _total,
      'items': _items,
      'clientEmail': _clientEmail,
      'clientPhoneNumber': _clientPhoneNumber,
    };
  }
}
