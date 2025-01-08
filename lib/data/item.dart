class Item {
  final String _barCode;
  final String _name;
  final String? _description;
  final double _price;
  final int _itemUnit;

  Item({
    required String barCode,
    required String name,
    String? description,
    required double price,
    required int itemUnit,
  })  : _barCode = barCode,
        _name = name,
        _description = description,
        _price = price,
        _itemUnit = itemUnit;

  String get barCode => _barCode;

  String get name => _name;

  String? get description => _description;

  double get price => _price;

  int get itemUnit => _itemUnit;

  Map toDic() {
    return {
      'barCode': _barCode,
      'name': _name,
      'description': _description,
      'price': _price,
      'itemUnit': _itemUnit,
    };
  }
}
