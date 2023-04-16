import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class AcceptButton extends StatelessWidget {
  const AcceptButton({
    super.key,
    required this.text,
    this.style = acceptButtonStyle,
    required this.onPressed,
  });

  final String text;
  final ButtonStyle style;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Text(
        text,
        style: UITextStyle.boldMeduim,
      ),
    );
  }
}
