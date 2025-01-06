import 'package:easy_bill_flutter/components/custom_popup_menu_button.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
import 'package:flutter/material.dart';

class SelectedItemCard extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdite;

  const SelectedItemCard(
      {super.key, required this.onEdite, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 70,
      decoration: BoxDecoration(
          color: kCustomCardBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: kBorderColor,
          )),
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 4),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Signal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    maxLines: 1,
                  ),
                  Text(
                    '0000000000000000',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '4 X 13.5',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  '54 dh',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child:
                  CustomPopupMenuButton(onDelete: onDelete, onEdite: onEdite),
            )
          ],
        ),
      ),
    );
  }
}
