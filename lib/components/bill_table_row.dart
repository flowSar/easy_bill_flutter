import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/styles.dart';

class BillTableRow extends StatelessWidget {
  final String product;
  final String quantity;
  final String price;
  final String total;

  const BillTableRow({
    super.key,
    required this.product,
    required this.quantity,
    required this.price,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(color: greyLight),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(product),
            Text(quantity),
            Text(price),
            Text(total),
          ],
        ),
      ),
    );
  }
}
