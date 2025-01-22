import 'package:easy_bill_flutter/components/custom_badge.dart';
import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:easy_bill_flutter/components/error_dialog.dart';
import 'package:easy_bill_flutter/modules/clients.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text_field.dart';
import '../../constants/colors.dart';
import '../../constants/g_constants.dart';
import '../../constants/icons.dart';
import '../../constants/styles.dart';
import 'package:uuid/uuid.dart';

final _formKey = GlobalKey<FormState>();
var uuid = Uuid();

class NewClientScreen extends StatefulWidget {
  final Client? client;

  const NewClientScreen({super.key, this.client});

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  late final TextEditingController _fullName;
  late final TextEditingController _address;
  late final TextEditingController _email;
  late final TextEditingController _phoneNumber;
  String? clientId;
  bool loading = false;

  @override
  void initState() {
    _fullName = TextEditingController();
    _address = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();

    if (widget.client != null) {
      clientId = widget.client!.clientId;
      _fullName.text = widget.client!.fullName;
      _address.text = widget.client!.address;
      _email.text = widget.client!.email;
      _phoneNumber.text = widget.client!.phoneNumber;
    }
    super.initState();
  }

  void displayErrorDialog(Object error) {
    showErrorDialog(context, 'Error', error);
  }

  // i get error after I leas this screen saying the TextField is being used after beign disposed.
  // that why I removed the dispose from here and I did add it to the CustomTextField component
  // @override
  // void dispose() {
  //   _fullName.dispose();
  //   _email.dispose();
  //   _fullName.dispose();
  //   _address.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Client'),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.close)),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Custombadge(
                    icon: kUserIcon,
                    labelIcon: Icons.image,
                    labelBg: Colors.blueGrey,
                  ),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyTextType,
                    controller: _fullName,
                    placeholder: 'Full Name',
                    title: 'fullName',
                    bg: kTextInputBg1,
                    validator: (name) =>
                        name!.length < 3 ? 'Please Insert valid Input' : null,
                  ),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyTextType,
                    controller: _address,
                    placeholder: 'Address',
                    title: 'Address',
                    bg: kTextInputBg1,
                  ),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyEmailType,
                    controller: _email,
                    placeholder: 'Email',
                    title: 'Email',
                    bg: kTextInputBg1,
                  ),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyPhoneType,
                    controller: _phoneNumber,
                    placeholder: 'Phone number',
                    title: 'phoneNumber',
                    bg: kTextInputBg1,
                  ),
                  CustomTextButton(
                    onPressed: () async {
                      Client client = Client(
                        clientId: clientId ?? uuid.v4(),
                        fullName: _fullName.text,
                        address: _address.text,
                        email: _email.text,
                        phoNumber: _phoneNumber.text,
                      );
                      bool? valid = _formKey.currentState?.validate();
                      if (valid == true) {
                        // context.pop(client);
                        try {
                          setState(() {
                            loading = true;
                          });
                          await context.read<DataProvider>().addClients(client);
                          setState(() {
                            loading = false;
                          });
                          _fullName.text = '';
                          _address.text = '';
                          _email.text = '';
                          _phoneNumber.text = '';
                        } catch (e) {
                          setState(() {
                            loading = false;
                          });
                          displayErrorDialog(e);
                        }
                        ;
                      }
                    },
                    label: loading
                        ? CustomCircularProgress()
                        : Text(
                            'save',
                            style: kTextStyle2b,
                          ),
                    w: 120,
                    h: 50,
                    bg: Colors.green,
                    fg: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
