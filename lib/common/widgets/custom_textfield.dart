import 'package:flutter/material.dart';

class Custom_textfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const Custom_textfield({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return " Enter your $hintText";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
