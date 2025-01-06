import 'package:easy_bill_flutter/components/custom_Floating_button.dart';
import 'package:easy_bill_flutter/components/custom_text_field.dart';
import 'package:easy_bill_flutter/components/empty.dart';
import 'package:easy_bill_flutter/components/item_card.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
import 'package:easy_bill_flutter/data/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  List<Item> items = [
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
    Item(
        barCode: '0987654543',
        description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
        name: 'signal',
        price: 12.5,
        itemUnit: 10),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
              child: items.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.only(bottom: height * 0.085),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          title: items[index].name,
                          subTitle: items[index].description,
                          tailing: items[index].price.toString(),
                          onTap: () {
                            Item currentItem = items[index];
                            context.push('/newItemScreen', extra: currentItem);
                          },
                          onDelete: () {},
                          onEdite: () {
                            Item currentItem = items[index];
                            context.push('/newItemScreen', extra: currentItem);
                          },
                        );
                      })
                  : Empty(
                      title: 'No Items',
                      subTitle: 'tap a Button Below to Create New Item',
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
  }
}
