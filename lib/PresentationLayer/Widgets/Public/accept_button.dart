import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class AcceptButton extends StatelessWidget {
  const AcceptButton({
    super.key,
    required this.text,
    this.style = acceptButtonStyle,
    this.backgroundColor = UIColors.primary,
    required this.onPressed,
  });

  final String text;
  final ButtonStyle style;
  final Color backgroundColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style.copyWith(
        backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
      ),
      child: Text(
        text,
        style: UITextStyle.boldMeduim,
      ),
    );
  }
}
