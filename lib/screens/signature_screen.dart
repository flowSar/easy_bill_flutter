import 'dart:io';

import 'package:easy_bill_flutter/components/custom_text_button.dart';
import 'package:easy_bill_flutter/components/error_dialog.dart';
import 'package:easy_bill_flutter/providers/data_provider.dart';
import 'package:easy_bill_flutter/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  late SignatureController controller;

  String? imagePath;
  File? fileImage;
  bool isDarkMode = false;

  @override
  void initState() {
    isDarkMode = context.read<SettingsProvider>().isDarMode;
    controller = SignatureController(
      penColor: isDarkMode ? Colors.white : Colors.black,
      penStrokeWidth: 3,
    );
    loadSignature();
    fileImage = context.read<DataProvider>().signature;
    super.initState();
  }

  Future loadSignature() async {
    await context.read<DataProvider>().loadSignature();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<String> saveImage(Uint8List signature) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/saved_image.png';
    File file = File(filePath);
    file.writeAsBytes(signature);
    return filePath;
  }

  void displayError(Object e) {
    showErrorDialog(context, 'signature error', '$e');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Signature'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          spacing: 6,
          children: [
            Signature(
              controller: controller,
              height: 180,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                CustomTextButton(
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });
                  },
                  label: Text('clear'),
                  bg: Colors.green,
                  fg: Colors.white,
                ),
                CustomTextButton(
                  onPressed: () async {
                    Uint8List? signature = await controller.toPngBytes();
                    try {
                      imagePath = await saveImage(signature!);
                      context.read<DataProvider>().addSignature(imagePath!);
                      fileImage = File(imagePath!);
                    } catch (e) {
                      displayError(e);
                    }
                    setState(() {});
                  },
                  label: Text('save'),
                  bg: Colors.green,
                  fg: Colors.white,
                ),
              ],
            ),
            if (fileImage != null)
              Image.file(
                fileImage!,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text('this signature is saved locally'))
          ],
        ),
      ),
    ));
  }
}
