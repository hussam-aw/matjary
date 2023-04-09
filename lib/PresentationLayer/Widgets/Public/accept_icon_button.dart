import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class AccetpIconButton extends StatelessWidget {
  const AccetpIconButton({
    super.key,
    required this.text,
    required this.icon,
    this.backgroundColor = UIColors.buttonBackground,
    required this.onPressed,
  });

  final Text text;
  final Icon icon;
  final Color backgroundColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: acceptButtonStyle.copyWith(
        backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            spacerWidth(width: 30),
            text,
          ],
        ),
      ),
    );
  }
}
