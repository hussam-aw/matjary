import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.child,
    this.style = acceptButtonStyle,
    this.backgroundColor = UIColors.continueButtonBackgroud,
    this.textStyle = UITextStyle.boldMeduim,
    required this.onPressed,
  });

  final Widget child;
  final ButtonStyle style;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style.copyWith(
        backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
      ),
      child: child,
    );
  }
}
