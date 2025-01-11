import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, title, errorMsg) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          titlePadding: EdgeInsets.only(top: 10, left: 10),
          actionsPadding: EdgeInsets.zero,
          scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(title),
          content: SizedBox(
            height: 86,
            child: Center(
              child: Text(
                errorMsg,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'ok',
                style: TextStyle(fontSize: 16, color: Colors.greenAccent[700]),
              ),
            ),
          ],
        );
      });
}
