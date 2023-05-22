import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  final String hintText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      style: UITextStyle.normalMeduim,
      decoration: normalTextFieldStyle.copyWith(
        hintText: hintText,
      ),
      onChanged: onChanged,
    );
  }
}
