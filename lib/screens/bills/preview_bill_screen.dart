import 'dart:io';

import 'package:easy_bill_flutter/components/bill_table_row.dart';
import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:easy_bill_flutter/components/error_dialog.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:easy_bill_flutter/modules/bill.dart';
import 'package:easy_bill_flutter/modules/business_info.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/settings_provider.dart';
import '../../utilities/generate_pdf.dart';

const kTableHeadTextStyle = TextStyle(fontSize: 15, color: Colors.white);

class PreviewBillScreen extends StatelessWidget {
  final Bill? bill;

  const PreviewBillScreen({super.key, this.bill});

  @override
  Widget build(BuildContext context) {
    void returnBack() {
      Navigator.of(context).pop();
    }

    void showError(Object e) {
      showErrorDialog(context, 'error', '$e');
    }

    String currency = context.read<SettingsProvider>().currency;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
              try {
                await context.read<DataProvider>().deleteBill(bill!.id);
                returnBack();
              } catch (e) {
                showError(e);
              }
            },
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 12,
              ),
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
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
                            'Bill NB: ${bill?.billNumber}',
                          ),
                          Text('created at: ${bill?.billDate}'),
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
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Description',
                              style: kTableHeadTextStyle,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'QTY',
                              style: kTableHeadTextStyle,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Price',
                              style: kTableHeadTextStyle,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Tax',
                              style: kTableHeadTextStyle,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'total',
                              style: kTableHeadTextStyle,
                            ),
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
                        total: bill?.items[index]['total'],
                        tax: bill?.items[index]['tax']);
                  }),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                // color: Colors.amber,
                border: Border.all(),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Total: ${bill?.total} $currency',
                  textAlign: TextAlign.center,
                  style: kTextStyle2b,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                BusinessInfo? businessInfo =
                    context.read<DataProvider>().businessInfo;
                File? signatureFile = context.read<DataProvider>().signature;
                PdfGenerator(currency);
                final pdfFile = await PdfGenerator.generatePdf(
                    bill!, businessInfo, signatureFile!);
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
                      'Save as Pdf',
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
