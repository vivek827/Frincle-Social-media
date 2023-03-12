import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPass;
  final TextInputType textInputType;
  TextFieldInput(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isPass = false,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      cursorColor: Theme.of(context).primaryColor,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
