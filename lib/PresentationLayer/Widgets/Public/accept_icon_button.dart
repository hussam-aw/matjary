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
    this.center = false,
    required this.onPressed,
  });

  final Text text;
  final Icon icon;
  final Color backgroundColor;
  final bool center;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: acceptButtonStyle.copyWith(
        backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Row(
            mainAxisAlignment:
                center ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Expanded(child: icon),
              Expanded(
                flex: 14,
                child: Center(child: text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
