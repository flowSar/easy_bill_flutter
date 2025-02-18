import 'package:easy_bill_flutter/components/bill_card.dart';
import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/empty.dart';
import 'package:easy_bill_flutter/constants/styles.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../modules/bill.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  bool loading = false;

  @override
  void initState() {
    loadBills();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // load all bills from database
  Future loadBills() async {
    try {
      // set loading state to true when this function called
      setState(() {
        loading = true;
      });
      // start loading data from database
      await context.read<DataProvider>().loadBills();
      // set loading to false data after data loading finished
      loading = false;
    } catch (e) {
      // set loading to false if loading failed and display the error
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, right: 16, left: 16),
            decoration: BoxDecoration(
              color: greyLight,
            ),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'Bills',
                  style: kTextStyle2b,
                  textAlign: TextAlign.center,
                )),
          ),
          Expanded(
            child:
                Consumer<DataProvider>(builder: (context, dataProvider, child) {
              List<Bill> bills = dataProvider.bills;
              // if loading = true , display loading widget
              if (loading) {
                return Center(
                  child: CustomCircularProgress(
                    w: 120,
                    h: 120,
                    strokeWidth: 4,
                  ),
                );
              } else {
                // if the bills 1= []display bills
                if (bills.isNotEmpty) {
                  return ListView.builder(
                    itemCount: bills.length,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.push('/previewBillScreen',
                              extra: bills[index]);
                        },
                        child: BillCard(
                          client: bills[index].clientName,
                          date: bills[index].billDate,
                          total: bills[index].total,
                          billNumber: bills[index].billNumber.toString(),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                      child: Empty(
                          title: 'No bill/invoice Was found', subTitle: ''));
                }
              }
            }),
          ),
        ],
      ),
    ));
  }
}
