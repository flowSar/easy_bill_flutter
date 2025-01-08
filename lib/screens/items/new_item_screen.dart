import 'package:easy_bill_flutter/components/text_card.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:easy_bill_flutter/data/item.dart';
import 'package:easy_bill_flutter/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/custom_Floating_button.dart';
import '../../components/custom_text_button.dart';
import '../../components/custom_text_field.dart';
import '../../utilities/scan_bard_code.dart';

final _formKey = GlobalKey<FormState>();

class NewItemScreen extends StatefulWidget {
  final Item? item;

  const NewItemScreen({super.key, this.item});

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
    if (widget.item != null) {
      barCode = widget.item!.barCode;
      _itemName.text = widget.item!.name ?? '';
      _description.text = widget.item!.description ?? '';
      _price.text = widget.item!.price.toString() ?? '';
      _itemUnit.text = widget.item!.itemUnit.toString() ?? '';
    }
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
            child: Form(
              key: _formKey,
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
                    validator: (name) =>
                        name!.length < 3 ? 'please Insert valid input' : null,
                  ),
                  CustomTextField(
                    controller: _description,
                    placeholder: 'Description',
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
                      bool? valid = _formKey.currentState?.validate();
                      if (valid == true) {
                        FireBaseManager firebaseManager = FireBaseManager();
                        String itemName = _itemName.text;
                        String price = _price.text.toString();
                        String unitItem = _itemUnit.text.toString();
                        Item item = Item(
                          barCode: barCode,
                          name: itemName,
                          description: _description.text,
                          price: double.parse(price),
                          itemUnit: int.parse(unitItem),
                        );
                        firebaseManager.addItem(item);
                        // context.pop(item);
                      }
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
