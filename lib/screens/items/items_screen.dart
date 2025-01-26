import 'package:easy_bill_flutter/components/custom_Floating_button.dart';
import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/custom_text_field.dart';
import 'package:easy_bill_flutter/components/empty.dart';
import 'package:easy_bill_flutter/components/item_card.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
import 'package:easy_bill_flutter/constants/g_constants.dart';
import 'package:easy_bill_flutter/modules/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';

class ItemsScreen extends StatefulWidget {
  final ScreenMode mode;

  const ItemsScreen({super.key, required this.mode});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  late final TextEditingController _searchKeyWord;
  bool loading = false;
  List<Item> items = [];

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
    _searchKeyWord = TextEditingController();
    loadItemsData();
    super.initState();
  }

  Future<void> loadItemsData() async {
    try {
      setState(() {
        loading = true;
      });
      // load all item from database
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
      items = dataProvider.items;

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
                controller: _searchKeyWord,
                bg: kTextInputBg1,
                placeholder: 'Search item name',
                title: 'Item Name',
                icon: Icon(Icons.search),
                onChanged: (value) {
                  setState(() {
                    dataProvider.flitterLists(value, 'items');
                  });
                },
                onErase: () {
                  dataProvider.flitterLists('', 'clients');
                  setState(() {
                    _searchKeyWord.text = '';
                  });
                },
              ),
              Expanded(
                child: loading
                    ? CustomCircularProgress(
                        w: 100,
                        h: 100,
                        strokeWidth: 6,
                      )
                    : items.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: loadItemsData,
                            child: ListView.builder(
                                padding:
                                    EdgeInsets.only(bottom: height * 0.085),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return ItemCard(
                                    title: items[index].name,
                                    subTitle: items[index].description,
                                    tailing: items[index].price.toString(),
                                    onTap: () {
                                      Item currentItem = items[index];
                                      print('mode: ${widget.mode}');
                                      if (widget.mode == ScreenMode.select) {
                                        print(
                                            'mode select--------------: ${widget.mode}');
                                        context.pop(currentItem);
                                      } else {
                                        print('mode navigate: ${widget.mode}');
                                        context.push('/newItemScreen',
                                            extra: currentItem);
                                      }
                                    },
                                    onDelete: () {
                                      context
                                          .read<DataProvider>()
                                          .deleteItem(items[index].barCode);
                                    },
                                    onEdite: () {
                                      Item currentItem = items[index];
                                      context.push('/newItemScreen',
                                          extra: currentItem);
                                    },
                                  );
                                }),
                          )
                        : SingleChildScrollView(
                            child: Empty(
                              title: 'No Items',
                              subTitle: 'tap a Button Below to Create New Item',
                              btnLabel: 'add New item',
                              onPressed: () => context.push('/newItemScreen'),
                            ),
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
                  items.add(item);
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
