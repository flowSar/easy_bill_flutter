import 'dart:io';

import 'package:easy_bill_flutter/components/bill_table_row.dart';
import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:easy_bill_flutter/data/bill.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/generate_pdf.dart';

const kTableHeadTextStyle = TextStyle(fontSize: 15, color: Colors.white);

class PreviewBillScreen extends StatelessWidget {
  final Bill? bill;

  const PreviewBillScreen({super.key, this.bill});

  @override
  Widget build(BuildContext context) {
    if (bill != null) {
      print(bill?.clientName);
    }
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<DataProvider>(
                          builder: (context, dataProvider, child) {
                        return Text(
                          dataProvider.businessInfo!.businessName,
                          style: kTextStyle2b.copyWith(fontSize: 26),
                        );
                      }),
                      Text(
                        'Bill#',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bill To',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18)),
                          Text(
                            '${bill?.clientName}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${bill?.clientEmail}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${bill?.clientPhoneNumber}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 4,
                        children: [
                          Text(
                            'Bill# 001',
                          ),
                          Text('creation date: ${bill?.billDate}'),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product',
                            style: kTableHeadTextStyle,
                          ),
                          Text(
                            'quantity',
                            style: kTableHeadTextStyle,
                          ),
                          Text(
                            'Price',
                            style: kTableHeadTextStyle,
                          ),
                          Text(
                            'total',
                            style: kTableHeadTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: bill?.items.length,
                  itemBuilder: (context, index) {
                    return BillTableRow(
                        product: bill?.items[index]['name'],
                        quantity: bill?.items[index]['quantity'],
                        price: bill?.items[index]['price'],
                        total: bill?.items[index]['total']);
                  }),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: Colors.yellowAccent),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Total: ${bill?.total} dh',
                  textAlign: TextAlign.center,
                  style: kTextStyle2b,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String? businessName =
                    context.read<DataProvider>().businessInfo?.businessName;
                final pdfFile =
                    await PdfGenerator.generatePdf(bill!, businessName);
                PdfGenerator.openFile(pdfFile);
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  )),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 4),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Text(
                      'Save Pdf',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
