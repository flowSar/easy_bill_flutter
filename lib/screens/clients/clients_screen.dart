import 'package:easy_bill_flutter/components/client_card.dart';
import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
import 'package:easy_bill_flutter/data/clients.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/custom_Floating_button.dart';
import '../../components/custom_text_field.dart';
import '../../components/empty.dart';
import '../../providers/data_provider.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  bool loading = false;

  @override
  void initState() {
    loadClientsData();
    super.initState();
  }

  Future<void> loadClientsData() async {
    setState(() {
      loading = true;
    });

    try {
      await context.read<DataProvider>().loadClientsData();
    } catch (e) {
      setState(() {
        loading = false;
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Manage Clients'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              CustomTextField(
                bg: kTextInputBg1,
                placeholder: 'Search client name',
                icon: Icon(Icons.search),
              ),
              Expanded(
                child: loading
                    ? CustomCircularProgress(
                        h: 100,
                        w: 100,
                        strokeWidth: 6,
                      )
                    : dataProvider.clients.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: loadClientsData,
                            child: ListView.builder(
                              padding: EdgeInsets.only(bottom: height * 0.085),
                              itemCount: dataProvider.clients.length,
                              itemBuilder: (context, index) {
                                return ClientCard(
                                  title: dataProvider.clients[index].fullName,
                                  subTitle: dataProvider.clients[index].email,
                                  onEdite: () {
                                    context.push('/newClientScreen',
                                        extra: dataProvider.clients[index]);
                                  },
                                  onDelete: () {
                                    context.read<DataProvider>().deleteClient(
                                        dataProvider.clients[index].clientId);
                                  },
                                  onTap: () {
                                    context.push('/newClientScreen',
                                        extra: dataProvider.clients[index]);
                                  },
                                );
                              },
                            ),
                          )
                        : Empty(
                            title: 'No clients',
                            subTitle: 'tap a Button Below to Create New client',
                            btnLabel: 'add New client',
                            onPressed: () => context.push('/newClientScreen'),
                          ),
              )
            ],
          ),
        ),
        floatingActionButton: CustomFloatingButton(
            w: 130,
            onPressed: () {
              context.push('/newClientScreen').then((newClient) {
                if (newClient != null) {
                  Client client = newClient as Client;
                  print('received: ${client.fullName}');
                  setState(() {
                    dataProvider.clients.add(client);
                  });
                }
              });
            },
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
                Text(
                  'New Client',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
      );
    });
  }
}
