import 'package:easy_bill_flutter/components/custom_popup_menu_button.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ClientCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Icon? icon;
  final VoidCallback onDelete;
  final VoidCallback onEdite;
  final VoidCallback onTap;

  const ClientCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon,
    required this.onEdite,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: kCustomCardBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black38,
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_circle_sharp,
                    size: 50,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text('Name: $title'),
                    Text('Email: $subTitle'),
                  ],
                ),
              ),
              CustomPopupMenuButton(onDelete: onDelete, onEdite: onEdite),
            ],
          ),
        ),
      ),
    );
  }
}
