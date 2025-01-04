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
          child: ListView(
            children: [
              ListTile(
                title: Text('Khalid'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
