import 'package:flutter/material.dart';

import '../constants/g_constants.dart';

class TextCard extends StatelessWidget {
  final Widget child;
  final Color? bg;
  final double? w;
  final double? elevation;

  const TextCard(
      {super.key, required this.child, this.bg, this.w, this.elevation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Material(
        elevation: elevation ?? 1,
        child: Container(
          width: w ?? maxW,
          decoration: BoxDecoration(
            color: bg ?? Colors.white30,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: child,
          ),
        ),
      ),
    );
  }
}
