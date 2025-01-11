import 'dart:math';

import 'package:easy_bill_flutter/components/client_card.dart';
import 'package:easy_bill_flutter/components/custom_Floating_button.dart';
import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/custom_modal_Bottom_sheet.dart';
import 'package:easy_bill_flutter/components/empty.dart';
import 'package:easy_bill_flutter/components/selected_item_card.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:easy_bill_flutter/data/bill.dart';
import 'package:easy_bill_flutter/providers/settings_provider.dart';
import 'package:easy_bill_flutter/utilities/scan_bard_code.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../components/select_item_button.dart';
import '../../components/user_card.dart';
import '../../constants/colors.dart';
import '../../data/clients.dart';
import '../../data/item.dart';
import '../../providers/data_provider.dart';

var uuid = Uuid();

class NewBillScreen extends StatefulWidget {
  const NewBillScreen({super.key});

  @override
  State<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends State<NewBillScreen> {
  ScanBarCode scanner = ScanBarCode();
  late String? barCode;
  late String selectedClient = 'Clients';
  bool loading = false;
  double billTotal = 0.0;
  List<Item> selectedItems = [];
  Client? client;
  List<Map<String, dynamic>> billRows = [];
  late Bill bill;
  late String currency;

  @override
  void initState() {
    loadBusinessInfo();
    currency = context.read<SettingsProvider>().currency;
    super.initState();
  }

  Future loadBusinessInfo() async {
    loading = true;
    try {
      await context.read<DataProvider>().loadBusinessInfo();
      loading = false;
    } catch (e) {
      print('loading: $e');
      loading = true;
    }
  }

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

    void fillDataIntoRows(String billId, billTotal) {
      billRows = [];
      int index = 0;
      for (var item in selectedItems) {
        double total = item.price * item.quantity;
        billRows.add(BillRow(
                id: index.toString(),
                name: item.name,
                quantity: item.quantity.toString(),
                price: item.price.toString(),
                total: total.toString(),
                tax: '0')
            .toDic());
        index++;
      }
      bill = Bill(
        id: billId,
        clientName: client?.fullName,
        billDate: '09/01/25',
        items: billRows,
        total: billTotal,
        clientEmail: client?.email,
        clientPhoneNumber: client?.phoneNumber,
      );
    }

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
                if (loading) {
                  return CustomCircularProgress(
                    strokeWidth: 2,
                    h: 35,
                    w: 35,
                  );
                } else {
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
                            bg: greyLight,
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
                  color: greyLight,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Text(
                  'Total: $billTotal $currency',
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
                onPressed: () async {
                  if (selectedItems.isNotEmpty) {
                    if (client != null) {
                      try {
                        String billId = uuid.v4();
                        fillDataIntoRows(billId, billTotal.toString());
                        await context.read<DataProvider>().addBill(bill);
                        setState(
                          () {
                            billRows = [];
                            selectedItems = [];
                          },
                        );
                      } catch (e) {
                        print('error: $e');
                      }
                    } else {
                      print('please select a client');
                    }
                  } else {
                    print('please select new Item');
                  }
                },
                w: 90,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.save,
                        color: Colors.white,
                      )
                    ],
                  ),
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
                w: 90,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Scan',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.barcode_reader,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
