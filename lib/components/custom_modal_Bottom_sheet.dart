import 'package:easy_bill_flutter/components/text_card.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/styles.dart';
import 'custom_text_button.dart';
import 'custom_text_field.dart';

final _formKey = GlobalKey<FormState>();

class CustomModalBottomSheet extends StatefulWidget {
  final String? barCode;

  const CustomModalBottomSheet({super.key, this.barCode});

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  late final TextEditingController _itemName;
  late final TextEditingController _price;
  late final TextEditingController _itemUnit;

  @override
  void initState() {
    _itemName = TextEditingController();
    _price = TextEditingController();
    _itemUnit = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late String? barCode = widget.barCode;
    return SizedBox(
      height: 600,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextCard(
                bg: kTextInputBg1,
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
              controller: _itemUnit,
              placeholder: 'Item unit',
              bg: kTextInputBg1,
              validator: (unit) =>
                  unit!.isEmpty ? 'please Insert valid input' : null,
            ),
            CustomTextButton(
              onPressed: () {
                Navigator.of(context).pop(_itemName.text);
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
    );
  }
}
