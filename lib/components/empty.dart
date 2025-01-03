import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String title;
  final String subTitle;

  const Empty({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 120,
            color: Colors.grey[600],
          ),
          Text(
            title,
            style: kTextStyle2b,
          ),
          Text(
            subTitle,
            style: kTextStyle2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
