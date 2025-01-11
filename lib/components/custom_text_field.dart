import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class CustomTextField extends StatefulWidget {
  final String? placeholder;
  final Widget? icon;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final Color? bg;
  final TextInputType? keyType;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool readOnly;
  final VoidCallback? onErase;

  const CustomTextField({
    super.key,
    this.placeholder,
    this.icon,
    this.controller,
    this.onChanged,
    this.bg,
    this.keyType,
    this.validator,
    this.initialValue,
    this.readOnly = false,
    this.onErase,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isDarkMode = false;

  @override
  void initState() {
    isDarkMode = context.read<SettingsProvider>().isDarMode;
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white : widget.bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          readOnly: widget.readOnly,
          initialValue: widget.initialValue,
          keyboardType: widget.keyType ?? TextInputType.text,
          controller: widget.controller,
          onChanged: widget.onChanged,
          style: isDarkMode ? TextStyle(color: Colors.red) : null,
          onTap: () {},
          decoration: InputDecoration(
            hintText: widget.placeholder,
            icon: widget.icon,
            suffix: GestureDetector(
              onTap: widget.onErase,
              child: Icon(
                Icons.close,
              ),
            ),
            border: InputBorder.none,
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
