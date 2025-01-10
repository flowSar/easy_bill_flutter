void main() {
  List<String> names = [
    'khalid',
    'mohammed',
    'yassine',
    'adil',
    'rachid',
    'saad',
    'said',
    'fatima',
    'malika'
  ];
  var newList = names.where((name) {
    if (name.contains('sai')) {
      return true;
    }
    return false;
  }).toList();
  print(names);
  print(newList);
}
