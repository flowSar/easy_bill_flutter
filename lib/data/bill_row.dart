import 'package:easy_bill_flutter/screens/bills/bills_screen.dart';

class BillRow {
  String _id;
  String _name;
  String _quantity;
  String _price;
  String _tax;
  String _total;

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
  String _id;
  String _clientName;
  String _billDate;
  List<BillsScreen> _items;

  Bill({required id, required clientName, required billDate, required items})
      : _id = id,
        _clientName = clientName,
        _billDate = billDate,
        _items = items;

  String get clientName => _clientName;

  String get id => _id;

  String get billDate => _billDate;

  List<BillsScreen> get items => _items;

  Map<String, dynamic> toDic() {
    return {
      'id': _id,
      'clientName': _clientName,
      'billDate': _billDate,
      'items': _items,
    };
  }
}
