import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class Empty extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? btnLabel;
  final VoidCallback? onPressed;

  const Empty({
    super.key,
    required this.title,
    required this.subTitle,
    this.btnLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: DottedBorder(
        dashPattern: [6, 3, 2, 3],
        color: Colors.grey,
        radius: Radius.circular(20),
        strokeWidth: 2,
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 100,
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
            btnLabel == null
                ? Text('')
                : CustomTextButton(
                    onPressed: onPressed ?? () {},
                    label: Text(btnLabel!),
                    w: 150,
                    bg: Colors.green,
                    fg: Colors.white,
                  ),
          ],
        ),
      ),
    );
  }
}
