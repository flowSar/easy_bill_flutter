import 'package:easy_bill_flutter/components/text_card.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/custom_Floating_button.dart';
import '../../components/custom_text_button.dart';
import '../../components/custom_text_field.dart';
import '../../utilities/scan_bard_code.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  late final TextEditingController _itemName;
  late final TextEditingController _description;
  late final TextEditingController _price;
  late final TextEditingController _itemUnit;
  late String barCode = '000000000000000';

  @override
  void initState() {
    _itemName = TextEditingController();
    _description = TextEditingController();
    _price = TextEditingController();
    _itemUnit = TextEditingController();
    super.initState();
  }

  ScanBarCode scanner = ScanBarCode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Item'),
          leading: InkWell(
            onTap: () => context.pop(),
            child: Icon(Icons.close),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
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
                        InkWell(
                          onTap: () async {
                            String result = await scanner.scan(context);
                            setState(() {
                              barCode = result;
                            });
                          },
                          child: Icon(Icons.add),
                        ),
                      ],
                    )),
                CustomTextField(
                  controller: _itemName,
                  placeholder: 'Item name',
                  bg: kTextInputBg1,
                ),
                CustomTextField(
                  controller: _description,
                  placeholder: 'Description',
                  bg: kTextInputBg1,
                ),
                CustomTextField(
                  controller: _price,
                  placeholder: 'Price',
                  bg: kTextInputBg1,
                ),
                CustomTextField(
                  controller: _itemUnit,
                  placeholder: 'Item unit',
                  bg: kTextInputBg1,
                ),
                CustomTextButton(
                  onPressed: () {
                    print(_itemName.text);
                    print(_description.text);
                    print(_price.text);
                    print(_itemUnit.text);
                  },
                  label: Text(
                    'save',
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
        floatingActionButton: CustomFloatingButton(
          onPressed: () async {
            String result = await scanner.scan(context);
            setState(() {
              barCode = result;
            });
          },
          child: Icon(
            Icons.barcode_reader,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
