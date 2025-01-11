import 'package:easy_bill_flutter/components/custom_popup_menu_button.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? tailing;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdite;

  const ItemCard({
    super.key,
    required this.title,
    this.subTitle = '',
    this.tailing = '',
    required this.onTap,
    required this.onDelete,
    required this.onEdite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: greyLight,
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        subTitle!,
                        maxLines: 1,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    tailing!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomPopupMenuButton(onDelete: onDelete, onEdite: onEdite),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
