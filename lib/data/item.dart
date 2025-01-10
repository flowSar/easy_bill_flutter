class Item {
  final String _barCode;
  final String _name;
  final String? _description;
  final double _price;
  final int _quantity;
  final String? _tax;

  Item({
    required String barCode,
    required String name,
    String? description,
    required double price,
    required int quantity,
    String? tax,
  })  : _barCode = barCode,
        _name = name,
        _description = description,
        _price = price,
        _quantity = quantity,
        _tax = tax;

  String get barCode => _barCode;

  String get name => _name;

  String? get description => _description;

  double get price => _price;

  int get quantity => _quantity;

  String? get tax => _tax;

  Map toDic() {
    return {
      'barCode': _barCode,
      'name': _name,
      'description': _description,
      'price': _price,
      'quantity': _quantity,
      'tax': _tax,
    };
  }
}
