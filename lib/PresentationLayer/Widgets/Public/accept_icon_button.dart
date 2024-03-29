import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class AcceptIconButton extends StatelessWidget {
  const AcceptIconButton({
    super.key,
    required this.text,
    required this.icon,
    this.backgroundColor = UIColors.continueButtonBackgroud,
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
              icon,
              spacerWidth(),
              Center(child: text),
            ],
          ),
        ),
      ),
    );
  }
}
