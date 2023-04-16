import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class CustomPinCodeFields extends StatelessWidget {
  const CustomPinCodeFields({super.key, required this.length});

  final int length;

  @override
  Widget build(BuildContext context) {
    return PinCodeFields(
      length: length,
      fieldBorderStyle: FieldBorderStyle.square,
      responsive: true,
      fieldHeight: 46,
      fieldWidth: 46,
      borderRadius: raduis15,
      keyboardType: TextInputType.number,
      autoHideKeyboard: false,
      fieldBackgroundColor: UIColors.textFieldBackground,
      borderColor: UIColors.textFieldBackground,
      textStyle: UITextStyle.normalMeduim,
      onComplete: (text) => print(text),
    );
  }
}
