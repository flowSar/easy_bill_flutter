import 'package:easy_bill_flutter/components/text_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/g_constants.dart';
import '../constants/styles.dart';
import '../modules/item.dart';
import '../providers/data_provider.dart';
import '../providers/settings_provider.dart';
import 'custom_text_button.dart';
import 'custom_text_field.dart';

final _formKey = GlobalKey<FormState>();

class CustomModalBottomSheet extends StatefulWidget {
  final String? barCode;
  final Item? item;

  const CustomModalBottomSheet({super.key, this.barCode, this.item});

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  late final TextEditingController _itemName;
  late final TextEditingController _price;
  late final TextEditingController _quantity;
  late final TextEditingController _tax;
  bool isDarkMode = false;

  // late Item? foundItem;

  @override
  void initState() {
    _itemName = TextEditingController();
    _price = TextEditingController();
    _quantity = TextEditingController();
    _tax = TextEditingController();

    if (widget.item != null) {
      _itemName.text = widget.item!.name;
      _price.text = widget.item!.price.toString();
      _quantity.text = widget.item!.quantity.toString();
      _tax.text = widget.item!.tax.toString();
    }
    isDarkMode = context.read<SettingsProvider>().isDarMode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late String? barCode = widget.barCode;
    return SingleChildScrollView(
      child: SizedBox(
        height: 600,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextCard(
                    bg: isDarkMode ? Colors.white : kTextInputBg1,
                    w: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'barCode: $barCode',
                          style: kTextStyle2,
                        ),
                      ],
                    )),
                CustomTextField(
                  controller: _itemName,
                  placeholder: 'Item name',
                  bg: kTextInputBg1,
                  validator: (name) =>
                      name!.length < 3 ? 'please Insert valid input' : null,
                ),
                CustomTextField(
                  controller: _price,
                  placeholder: 'Price',
                  bg: kTextInputBg1,
                  validator: (price) =>
                      price!.isEmpty ? 'please Insert valid input' : null,
                ),
                CustomTextField(
                  controller: _quantity,
                  placeholder: 'Item quantity',
                  bg: kTextInputBg1,
                  validator: (quantity) =>
                      quantity!.isEmpty ? 'please Insert valid input' : null,
                ),
                CustomTextField(
                  controller: _tax,
                  keyType: kKeyNumberType,
                  placeholder: 'Tax Percentage',
                  bg: kTextInputBg1,
                  validator: (quantity) =>
                      quantity!.isEmpty ? 'please Insert valid input' : null,
                ),
                CustomTextButton(
                  onPressed: () {
                    Item newItem = Item(
                      barCode: widget.barCode!,
                      name: _itemName.text,
                      price: double.parse(_price.text),
                      quantity: int.parse(_quantity.text),
                      tax: _tax.text,
                    );
                    context.pop(newItem);
                  },
                  label: Text(
                    'add',
                    style: kTextStyle2b,
                  ),
                  w: 120,
                  h: 50,
                  bg: Colors.green,
                  fg: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
