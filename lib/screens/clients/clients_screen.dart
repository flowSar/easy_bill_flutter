import 'package:easy_bill_flutter/components/client_card.dart';
import 'package:easy_bill_flutter/constants/colors.dart';
import 'package:easy_bill_flutter/data/clients.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/custom_Floating_button.dart';
import '../../components/custom_text_field.dart';
import '../../components/empty.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  List<Client> clients = [
    Client(
        fullName: 'khalid',
        address: 'lakmakssa casa blanca',
        email: 'khalid@gmail.com',
        phoNumber: '0987654312'),
    Client(
        fullName: 'brahim',
        address: 'lakmakssa casa blanca',
        email: 'brahim@gmail.com',
        phoNumber: '0987654312'),
    Client(
        fullName: 'rachid',
        address: 'lakmakssa casa blanca',
        email: 'rachid@gmail.com',
        phoNumber: '0987654312'),
    Client(
        fullName: 'said',
        address: 'lakmakssa casa blanca',
        email: 'said@gmail.com',
        phoNumber: '0987654312'),
    Client(
        fullName: 'fatima',
        address: 'lakmakssa casa blanca',
        email: 'fatima@gmail.com',
        phoNumber: '0987654312'),
    Client(
        fullName: 'hassan',
        address: 'lakmakssa casa blanca',
        email: 'hassan@gmail.com',
        phoNumber: '0987654312'),
    Client(
        fullName: 'ahmed',
        address: 'lakmakssa casa blanca',
        email: 'ahmed@gmail.com',
        phoNumber: '0987654312'),
    Client(
        fullName: 'khalid',
        address: 'lakmakssa casa blanca',
        email: 'khalid@gmail.com',
        phoNumber: '0987654312'),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
              child: clients.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.only(bottom: height * 0.085),
                      itemCount: clients.length,
                      itemBuilder: (context, index) {
                        return ClientCard(
                          title: clients[index].fullName,
                          subTitle: clients[index].email,
                          onEdite: () {},
                          onDelete: () {},
                          onTap: () {
                            context.push('/newClientScreen',
                                extra: clients[index]);
                          },
                        );
                      },
                    )
                  : Empty(
                      title: 'No clients',
                      subTitle: 'tap a Button Below to Create New client',
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
                  clients.add(client);
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
  }
}
