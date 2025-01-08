import 'package:easy_bill_flutter/components/client_card.dart';
import 'package:easy_bill_flutter/components/custom_Floating_button.dart';
import 'package:easy_bill_flutter/components/custom_modal_Bottom_sheet.dart';
import 'package:easy_bill_flutter/components/empty.dart';
import 'package:easy_bill_flutter/components/selected_item_card.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:easy_bill_flutter/utilities/scan_bard_code.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/select_item_button.dart';
import '../../components/user_card.dart';
import '../../constants/colors.dart';
import '../../data/clients.dart';
import '../../data/item.dart';
import '../../providers/data_provider.dart';

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
  double billTotal = 0.0;
  List<Item> selectedItems = [];
  Client? client;

  @override
  Widget build(BuildContext context) {
    Item? filterByBarCode(String? barCode) {
      List<Item> items = context.read<DataProvider>().items;
      for (var item in items) {
        if (item.barCode == barCode) {
          print('found: ${item.barCode}');
          return item;
        }
      }
      return null;
    }

    double getBillTotal() {
      double total = 0.0;
      for (var item in selectedItems) {
        total += item.quantity * item.price;
      }
      return total;
    }

    late double billTotal = getBillTotal();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              client != null
                  ? UserCard(
                      title: client!.fullName,
                      subTitle: client!.email,
                      elevation: 2,
                      onPressed: () {
                        context.push('/clientListScreen').then((newClient) {
                          if (newClient != null) {
                            setState(() {
                              client = newClient as Client;
                              print('selected client ${client?.fullName}');
                            });
                          }
                        });
                      },
                    )
                  : SelectItemButton(
                      elevation: 2,
                      label: 'Select Client',
                      onPressed: () {
                        context.push('/clientListScreen').then((newClient) {
                          if (newClient != null) {
                            setState(() {
                              client = newClient as Client;
                              print('selected client ${client?.fullName}');
                            });
                          }
                        });
                      },
                    ),
              Consumer<DataProvider>(builder: (context, dataProvider, child) {
                final businessInfo = dataProvider.businessInfo;
                if (businessInfo != null) {
                  return UserCard(
                      onPressed: () {
                        context.push('/businessScreen');
                      },
                      elevation: 2,
                      title: businessInfo.businessName,
                      subTitle: businessInfo.businessEmail!);
                } else {
                  return SelectItemButton(
                    elevation: 2,
                    label: 'Business Info',
                    onPressed: () {
                      context.push('/clientListScreen');
                    },
                  );
                }
              }),
              Expanded(
                child: selectedItems.isNotEmpty
                    ? ListView.builder(
                        itemCount: selectedItems.length,
                        itemBuilder: (context, index) {
                          return SelectedItemCard(
                            onEdite: () {},
                            onDelete: () {
                              setState(() {
                                selectedItems.removeAt(index);
                              });
                            },
                            bg: Colors.grey[50],
                            name: selectedItems[index].name,
                            barCode: selectedItems[index].barCode,
                            quantity: selectedItems[index].quantity,
                            price: selectedItems[index].price,
                          );
                        })
                    : Empty(
                        title: 'No Item was added',
                        subTitle: 'Add new Item by scanning the barCode',
                      ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Text(
                  'Total: $billTotal \$',
                  style: kTextStyle2b.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
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
                    // check is the code bar scanned and the return value is not -1
                    if (barCode != '-1') {
                      // filter the item and check if the codeBar is in database
                      Item? item = filterByBarCode(barCode?.trim());
                      // if the item is found navigate to the
                      if (item != null) {
                        Item? newItem = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) =>
                              CustomModalBottomSheet(
                            barCode: barCode,
                            item: item,
                          ),
                        );
                        if (newItem != null) {
                          setState(() {
                            selectedItems.add(newItem);
                          });
                        }
                      } else {
                        // if the code bar was not found create navigate to screen where you can add this new item
                        Item newItem = Item(
                            barCode: barCode!, name: '', price: 0, quantity: 0);
                        context.push('/newItemScreen', extra: newItem);
                      }
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
