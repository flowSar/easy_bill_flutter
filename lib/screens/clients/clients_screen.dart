import 'package:easy_bill_flutter/constants/colors.dart';
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
  @override
  Widget build(BuildContext context) {
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
              child: Empty(
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
            context.push('/newClientScreen');
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
