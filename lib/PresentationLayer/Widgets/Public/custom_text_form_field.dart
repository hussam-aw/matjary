import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.keyboardType = TextInputType.name,
    this.obsecureText = false,
    this.style = UITextStyle.normalBody,
    this.maxLines = 1,
    this.readOnly = false,
    this.formatters,
    this.suffix,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obsecureText;
  final TextStyle style;
  final int maxLines;
  final bool readOnly;
  final List<TextInputFormatter>? formatters;
  final Widget? suffix;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatters,
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obsecureText,
      style: style,
      maxLines: maxLines,
      decoration: textFieldStyle.copyWith(
        hintText: hintText,
        suffixIcon: suffix,
      ),
      onChanged: onChanged,
    );
  }
}
