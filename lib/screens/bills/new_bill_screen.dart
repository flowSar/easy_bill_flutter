import 'package:easy_bill_flutter/components/custom_Floating_button.dart';
import 'package:easy_bill_flutter/components/custom_modal_Bottom_sheet.dart';
import 'package:easy_bill_flutter/components/selected_item_card.dart';
import 'package:easy_bill_flutter/utilities/scan_bard_code.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/select_item_button.dart';

class NewBillScreen extends StatefulWidget {
  const NewBillScreen({super.key});

  @override
  State<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends State<NewBillScreen> {
  ScanBarCode scanner = ScanBarCode();
  late String? barCode;
  late String selectedClient = 'Clients';
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Column(
            children: [
              SelectItemButton(
                label: 'Select Client',
                onPressed: () {
                  context.push('/clientListScreen');
                },
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.green,
                child: Text('selected Items'),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return SelectedItemCard(
                        onEdite: () {},
                        onDelete: () {},
                      );
                    }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.all(0),
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomFloatingButton(
                onPressed: () {},
                child: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              ),
              CustomFloatingButton(
                onPressed: () async {
                  String result = await scanner.scan(context);
                  setState(() async {
                    barCode = result;
                    if (barCode != '-1') {
                      String fullName = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) =>
                            CustomModalBottomSheet(
                          barCode: barCode,
                        ),
                      );
                      print('full naming coming from modal: $fullName');
                    } else {
                      print('');
                    }
                  });
                },
                child: Icon(
                  Icons.barcode_reader,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
