import 'package:flutter/material.dart';

final kBillCardText = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
  color: Colors.blue,
);

class BillCard extends StatelessWidget {
  final String client;
  final String date;
  final String billNumber;
  final String total;

  const BillCard({
    super.key,
    required this.client,
    required this.date,
    required this.billNumber,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            spacing: 6,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    client,
                    style: kBillCardText,
                  ),
                  Text(
                    'B.N: 0000$billNumber',
                    style: kBillCardText,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'due',
                    style: kBillCardText.copyWith(color: Colors.black),
                  ),
                  Text(
                    date,
                    style: kBillCardText,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: kBillCardText.copyWith(color: Colors.black),
                  ),
                  Text(
                    '$total dh',
                    style: kBillCardText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
