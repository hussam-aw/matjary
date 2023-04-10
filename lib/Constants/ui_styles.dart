import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

// ElevatedButton Styles
const acceptButtonStyle = ButtonStyle(
  elevation: MaterialStatePropertyAll(0),
  backgroundColor: MaterialStatePropertyAll<Color>(UIColors.primary),
  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: raduis15,
    ),
  ),
  minimumSize: MaterialStatePropertyAll<Size>(
    Size(double.infinity, 44),
  ),
);

final acceptButtonWithBorderStyle = acceptButtonStyle.copyWith(
  backgroundColor:
      const MaterialStatePropertyAll<Color>(UIColors.mainBackground),
  shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: raduis15,
      side: BorderSide(width: 1, color: UIColors.white),
    ),
  ),
);

// Input Styles
final textFieldStyle = InputDecoration(
  filled: true,
  fillColor: UIColors.textFieldBackground,
  contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: UIColors.red,
    ),
    borderRadius: BorderRadius.circular(15),
  ),
  hintStyle: UITextStyle.normalBody.copyWith(
    color: UIColors.normalText,
  ),
);

final normalTextFieldStyle = InputDecoration(
  hintStyle: UITextStyle.normalBody.copyWith(color: UIColors.normalText),
  enabledBorder: const UnderlineInputBorder(
    borderSide: BorderSide(
      color: UIColors.textFieldBackground,
    ),
  ),
);

// Border Radius
const raduis15 = BorderRadius.all(Radius.circular(15));
const radius19 = BorderRadius.all(Radius.circular(19));
const raduis32top = BorderRadius.only(
  topLeft: Radius.circular(32),
  topRight: Radius.circular(32),
);
const raduis42top = BorderRadius.only(
  topLeft: Radius.circular(42),
  topRight: Radius.circular(42),
);
