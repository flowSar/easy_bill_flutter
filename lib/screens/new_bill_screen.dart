import 'package:easy_bill_flutter/components/custom_Floating_button.dart';
import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:easy_bill_flutter/data/clients.dart';
import 'package:easy_bill_flutter/utilities/scan_bard_code.dart';
import 'package:flutter/material.dart';

import '../components/select_item_button.dart';

class NewBillScreen extends StatefulWidget {
  const NewBillScreen({super.key});

  @override
  State<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends State<NewBillScreen> {
  ScanBarCode scanner = ScanBarCode();
  late String barCode = 'barcode';
  late String selectedClient = 'Clients';
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    SelectItemButton(
                      label: 'Select Client',
                      onPressed: () {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(barCode),
                        CustomTextButton(
                          onPressed: () async {
                            String result = await scanner.scan(context);
                            print('barCode: $result');
                            setState(() {
                              barCode = result;
                            });
                          },
                          label: Text('Scan'),
                          bg: Colors.blueAccent,
                          fg: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text('quantity'),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('product'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('price'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('total'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Text('hello')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomFloatingButton(
                    onPressed: () {},
                    child: Icon(Icons.save),
                  ),
                  CustomFloatingButton(
                    onPressed: () {},
                    child: Icon(Icons.barcode_reader),
                  ),
                ],
              )
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     String result = await scanner.scan(context);
        //     print('barCode: $result');
        //     setState(() {
        //       barCode = result;
        //     });
        //   },
        //   child: Icon(Icons.barcode_reader),
        // ),
      ),
    );
  }
}
