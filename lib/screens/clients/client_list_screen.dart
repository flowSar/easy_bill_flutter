import 'package:easy_bill_flutter/components/client_card.dart';
import 'package:easy_bill_flutter/data/clients.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientListScreen extends StatelessWidget {
  const ClientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                return ClientCard(
                  title: clients[index].fullName,
                  subTitle: clients[index].email,
                  onEdite: () {},
                  onDelete: () {},
                  onTap: () {},
                );
              }),
        ),
      ),
    );
  }
}
