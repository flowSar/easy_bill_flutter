import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/text_card.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:easy_bill_flutter/modules/item.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:easy_bill_flutter/utilities/functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/custom_Floating_button.dart';
import '../../components/custom_text_button.dart';
import '../../components/custom_text_field.dart';
import '../../components/error_dialog.dart';
import '../../constants/g_constants.dart';
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
  late final TextEditingController _quantity;
  late final TextEditingController _tax;
  late String barCode = 'Scan the bar Code';
  bool loading = false;

  @override
  void initState() {
    _itemName = TextEditingController();
    _description = TextEditingController();
    _price = TextEditingController();
    _quantity = TextEditingController();
    _tax = TextEditingController();

    // check if the item is not null this mean that item was passed to the screen
    // so assign this item data to each TextField as a default data
    if (widget.item != null) {
      barCode = widget.item!.barCode;
      _itemName.text = widget.item!.name;
      _description.text = widget.item!.description ?? '';
      _price.text = widget.item!.price.toString();
      _quantity.text = widget.item!.quantity.toString();
      _tax.text = widget.item!.tax!;
    }
    super.initState();
  }

  // create instance from the barCode class so we can call its function to scan the barfCode
  ScanBarCode scanner = ScanBarCode();

  // function for displaying the error dialog
  void displayErrorDialog(Object e) {
    showErrorDialog(context, 'Error', e.toString());
  }

  @override
  Widget build(BuildContext context) {
    void displaySnackBar(String msg) {
      snackBar(context, msg);
    }

    // clear all user input
    void clearUserInput() {
      _itemName.clear();
      _description.clear();
      _price.clear();
      _quantity.clear();
      _tax.clear();
      barCode = 'Scan the bar Code';
    }

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
                      w: 340,
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
                    readOnly: loading,
                    controller: _itemName,
                    keyType: kKeyTextType,
                    placeholder: 'Item name',
                    title: 'Name: ',
                    bg: kTextInputBg1,
                    validator: (name) =>
                        name!.length < 3 ? 'please Insert valid input' : null,
                    onErase: () => _itemName.clear(),
                  ),
                  CustomTextField(
                    readOnly: loading,
                    controller: _description,
                    title: 'Description: ',
                    keyType: kKeyTextType,
                    placeholder: 'Description',
                    bg: kTextInputBg1,
                    validator: (name) =>
                        name!.length < 3 ? 'please Insert valid input' : null,
                    onErase: () => _description.clear(),
                  ),
                  CustomTextField(
                    readOnly: loading,
                    controller: _price,
                    keyType: kKeyNumberType,
                    placeholder: 'Price',
                    title: 'Price: ',
                    bg: kTextInputBg1,
                    validator: (price) =>
                        price!.isEmpty ? 'please Insert valid input' : null,
                    onErase: () => _price.clear(),
                  ),
                  CustomTextField(
                    readOnly: loading,
                    controller: _quantity,
                    keyType: kKeyNumberType,
                    placeholder: 'Item quantity',
                    title: 'Quantity: ',
                    bg: kTextInputBg1,
                    validator: (quantity) =>
                        quantity!.isEmpty ? 'please Insert valid input' : null,
                    onErase: () => _quantity.clear(),
                  ),
                  CustomTextField(
                    readOnly: loading,
                    controller: _tax,
                    keyType: kKeyNumberType,
                    placeholder: 'Tax Percentage',
                    title: 'Tax %: ',
                    bg: kTextInputBg1,
                    validator: (tax) =>
                        tax!.isEmpty ? 'please Insert valid input' : null,
                    onErase: () => _tax.clear(),
                  ),
                  CustomTextButton(
                    onPressed: () async {
                      // check if the input is valid before submitting it
                      bool? valid = _formKey.currentState?.validate();
                      if (valid == true) {
                        String itemName = _itemName.text;
                        String price = _price.text.toString();
                        String quantity = _quantity.text.toString();
                        // create Item object
                        Item item = Item(
                          barCode: barCode,
                          name: itemName,
                          description: _description.text,
                          price: double.parse(price),
                          quantity: int.parse(quantity),
                          tax: _tax.text,
                        );
                        try {
                          setState(() {
                            loading = true;
                          });
                          // submit the new item to the database
                          await context.read<DataProvider>().addItem(item);
                          setState(() {
                            loading = false;
                          });
                          // after the submitting succeed remove all user input
                          displaySnackBar('the Item was added successfully');
                          // clear user input
                          clearUserInput();
                        } catch (e) {
                          setState(() {
                            loading = false;
                          });
                          displayErrorDialog(e);
                        }
                        // context.pop(item);
                      }
                    },
                    label: loading
                        ? CustomCircularProgress()
                        : Text(
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
