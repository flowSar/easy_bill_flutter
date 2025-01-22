import 'package:easy_bill_flutter/components/custom_Floating_button.dart';
import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/custom_modal_Bottom_sheet.dart';
import 'package:easy_bill_flutter/components/empty.dart';
import 'package:easy_bill_flutter/components/error_dialog.dart';
import 'package:easy_bill_flutter/components/selected_item_card.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:easy_bill_flutter/modules/bill.dart';
import 'package:easy_bill_flutter/providers/settings_provider.dart';
import 'package:easy_bill_flutter/utilities/scan_bard_code.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../components/select_item_button.dart';
import '../../components/user_card.dart';
import '../../constants/colors.dart';
import '../../modules/clients.dart';
import '../../modules/item.dart';
import '../../providers/data_provider.dart';
import 'package:intl/intl.dart';

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
  DateTime now = DateTime.now();
  late String date;

  @override
  void initState() {
    loadBusinessInfo();
    currency = context.read<SettingsProvider>().currency;

    date = DateFormat('dd/MM/yyyy').format(now);
    super.initState();
  }

  Future loadBusinessInfo() async {
    setState(() {
      loading = true;
    });
    try {
      await context.read<DataProvider>().loadBusinessInfo();
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // we filter all the item by barcode so we can extract the object we need
    Item? filterByBarCode(String? barCode) {
      List<Item> items = context.read<DataProvider>().items;
      for (var item in items) {
        if (item.barCode == barCode) {
          return item;
        }
      }
      return null;
    }

    // we calculate the bill total by iterating over the list of items and sum their total
    double getBillTotal() {
      double total = 0.0;
      double subTotal = 0.0;
      for (var item in selectedItems) {
        double tax = double.parse(item.tax ?? '0');
        subTotal = item.quantity * item.price;
        total += subTotal + (subTotal * tax) / 100;
      }
      return total;
    }

    late double billTotal = getBillTotal();

    // we fill data into a list of billRows so we can add this list to the bill
    // we fill the object( from Bill) that will cary all the data that we will send to the base
    void fillDataIntoRows(String billId, billTotal) {
      billRows = [];
      int index = 0;
      for (var item in selectedItems) {
        double tax = double.parse(item.tax!);
        double subtotal = item.price * item.quantity;
        double total = subtotal + (subtotal * tax) / 100;
        billRows.add(BillRow(
          id: index.toString(),
          name: item.name,
          quantity: item.quantity.toString(),
          price: item.price.toString(),
          total: total.toString(),
          tax: item.tax,
        ).toDic());
        index++;
      }
      bill = Bill(
        id: billId,
        clientName: client?.fullName,
        billDate: date,
        items: billRows,
        total: billTotal,
        clientEmail: client?.email,
        clientPhoneNumber: client?.phoneNumber,
        billNumber: context.read<DataProvider>().bills.length + 1,
      );
    }

    // this function is calling the custom widget for displaying the error
    void errorDialog(Object e) {
      showErrorDialog(context, "Error ", 'error: $e');
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
                            });
                          }
                        });
                      },
                    ),
              Consumer<DataProvider>(builder: (context, dataProvider, child) {
                // check is the loading data from database is still ongoing
                if (loading) {
                  return CustomCircularProgress(
                    strokeWidth: 2,
                    h: 35,
                    w: 35,
                  );
                } else {
                  loadBusinessInfo();
                  final bInfo = dataProvider.businessInfo;
                  if (bInfo != null) {
                    return UserCard(
                        onPressed: () {
                          context.push('/businessScreen');
                        },
                        elevation: 2,
                        title: bInfo.businessName,
                        subTitle: bInfo.businessEmail!);
                  } else {
                    return SelectItemButton(
                      elevation: 2,
                      label: 'Business Info',
                      onPressed: () {
                        context.push('/businessScreen');
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
                            tax: selectedItems[index].tax ?? '0',
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
                        errorDialog(e);
                      }
                    } else {
                      showErrorDialog(
                          context, "Error ", 'please select the client');
                    }
                  } else {
                    showErrorDialog(
                        context, "Error ", 'please select new Item');
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
