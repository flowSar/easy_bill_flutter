import 'package:easy_bill_flutter/components/CustomBadge.dart';
import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../components/custom_text_field.dart';
import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/styles.dart';

class NewClientScreen extends StatefulWidget {
  const NewClientScreen({super.key});

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  late final TextEditingController _fullName;
  late final TextEditingController _address;
  late final TextEditingController _email;
  late final TextEditingController _phoneNumber;

  @override
  void initState() {
    _fullName = TextEditingController();
    _address = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();
    super.initState();
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
            child: Column(
              children: [
                Custombadge(
                  icon: kUserIcon,
                  labelIcon: Icons.image,
                  labelBg: Colors.blueGrey,
                ),
                CustomTextField(
                  controller: _fullName,
                  placeholder: 'Full Name',
                  bg: kTextInputBg1,
                ),
                CustomTextField(
                  controller: _address,
                  placeholder: 'Address',
                  bg: kTextInputBg1,
                ),
                CustomTextField(
                  controller: _email,
                  placeholder: 'Email',
                  bg: kTextInputBg1,
                ),
                CustomTextField(
                  controller: _phoneNumber,
                  placeholder: 'Phone number',
                  bg: kTextInputBg1,
                ),
                CustomTextButton(
                  onPressed: () {
                    print(_fullName.text);
                    print(_address.text);
                    print(_email.text);
                    print(_phoneNumber.text);
                  },
                  label: Text(
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
    );
  }
}
