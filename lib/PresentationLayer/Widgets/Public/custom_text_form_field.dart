import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.keyboardType = TextInputType.name,
    this.style = UITextStyle.normalBody,
    this.maxLines = 1,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextStyle style;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: style,
      maxLines: maxLines,
      decoration: textFieldStyle.copyWith(
        hintText: hintText,
      ),
    );
  }
}
