import 'package:easy_bill_flutter/components/client_card.dart';
import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/error_dialog.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text_field.dart';
import '../../components/empty.dart';
import '../../constants/colors.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  bool loading = false;
  late TextEditingController _searchKeyWord;

  @override
  void initState() {
    _searchKeyWord = TextEditingController();
    loadClientsData();
    super.initState();
  }

  Future<void> loadClientsData() async {
    setState(() {
      loading = true;
    });
    try {
      // load clients data from database
      await context.read<DataProvider>().loadClientsData();
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  void displayErrorDialog(Object e) {
    showErrorDialog(context, 'Error', e.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Clients List'),
            leading: InkWell(
              onTap: () => context.pop(),
              child: Icon(
                Icons.close,
              ),
            ),
          ),
          body: Column(
            children: [
              CustomTextField(
                controller: _searchKeyWord,
                bg: kTextInputBg1,
                placeholder: 'Search client name',
                title: 'Client Name',
                icon: Icon(Icons.search),
                onChanged: (value) {
                  setState(() {
                    dataProvider.flitterLists(value, 'clients');
                  });
                },
                onErase: () {
                  dataProvider.flitterLists('', 'clients');
                  setState(() {
                    _searchKeyWord.text = '';
                  });
                },
              ),
              Expanded(
                child: loading
                    ? Center(
                        child: CustomCircularProgress(
                          w: 100,
                          h: 100,
                          strokeWidth: 6,
                        ),
                      )
                    : dataProvider.clients.isNotEmpty
                        ? ListView.builder(
                            itemCount: dataProvider.clients.length,
                            itemBuilder: (context, index) {
                              return ClientCard(
                                title: dataProvider.clients[index].fullName,
                                subTitle: dataProvider.clients[index].email,
                                onEdite: () {
                                  context.push(
                                    '/newClientScreen',
                                    extra: dataProvider.clients[index],
                                  );
                                },
                                onDelete: () {},
                                onTap: () {
                                  context.pop(dataProvider.clients[index]);
                                },
                              );
                            },
                          )
                        : Center(
                            child: SingleChildScrollView(
                              child: Empty(
                                title: 'No clients',
                                subTitle:
                                    'tap a Button Below to Create New client',
                                btnLabel: 'Create New Client',
                                onPressed: () {
                                  context.push('/newClientScreen');
                                },
                              ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
