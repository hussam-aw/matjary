import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.buttonText,
    this.backgroundColor = UIColors.red,
    required this.confirmOnPressed,
  });

  final String title;
  final String buttonText;
  final Color backgroundColor;
  final Function() confirmOnPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      actions: [
        AcceptButton(
          text: buttonText,
          backgroundColor: backgroundColor,
          onPressed: confirmOnPressed,
        )
      ],
    );
  }
}
