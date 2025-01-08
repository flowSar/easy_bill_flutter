import 'package:easy_bill_flutter/components/custom_Floating_button.dart';
import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/custom_text_field.dart';
import 'package:easy_bill_flutter/components/empty.dart';
import 'package:easy_bill_flutter/components/item_card.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
import 'package:easy_bill_flutter/data/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  bool loading = false;

  // List<Item> items = [
  //   Item(
  //       barCode: '0987654543',
  //       description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
  //       name: 'signal',
  //       price: 12.5,
  //       quantity: 10),
  // ];
  @override
  void initState() {
    // load all item from the database
    loadItemsData();
    super.initState();
  }

  Future<void> loadItemsData() async {
    setState(() {
      loading = true;
    });

    try {
      await context.read<DataProvider>().loadItemsData();
    } catch (e) {
      setState(() {
        loading = false;
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Manage Items'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              CustomTextField(
                bg: kTextInputBg1,
                placeholder: 'Search item name',
                icon: Icon(Icons.search),
              ),
              Expanded(
                child: loading
                    ? CustomCircularProgress(
                        w: 100,
                        h: 100,
                        strokeWidth: 6,
                      )
                    : dataProvider.items.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: loadItemsData,
                            child: ListView.builder(
                                padding:
                                    EdgeInsets.only(bottom: height * 0.085),
                                itemCount: dataProvider.items.length,
                                itemBuilder: (context, index) {
                                  return ItemCard(
                                    title: dataProvider.items[index].name,
                                    subTitle:
                                        dataProvider.items[index].description,
                                    tailing: dataProvider.items[index].price
                                        .toString(),
                                    onTap: () {
                                      Item currentItem =
                                          dataProvider.items[index];
                                      context.push('/newItemScreen',
                                          extra: currentItem);
                                    },
                                    onDelete: () {},
                                    onEdite: () {
                                      Item currentItem =
                                          dataProvider.items[index];
                                      context.push('/newItemScreen',
                                          extra: currentItem);
                                    },
                                  );
                                }),
                          )
                        : Empty(
                            title: 'No Items',
                            subTitle: 'tap a Button Below to Create New Item',
                            btnLabel: 'add New item',
                            onPressed: () => context.push('/newItemScreen'),
                          ),
              )
            ],
          ),
        ),
        floatingActionButton: CustomFloatingButton(
          w: 120,
          onPressed: () {
            context.push('/newItemScreen').then((returnedItem) {
              if (returnedItem != null) {
                Item item = returnedItem as Item;
                setState(() {
                  dataProvider.items.add(item);
                });
              }
            });
          },
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              Text(
                'New Item',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    });
  }
}
