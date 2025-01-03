import 'package:flutter/material.dart';

class SelectItemButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const SelectItemButton(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(15),
      constraints: BoxConstraints(maxWidth: 300),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1, color: Colors.black38)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Icon(Icons.add),
        ],
      ),
    );
  }
}
