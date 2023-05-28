import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.widget,
    required this.onTap,
  });

  final Widget widget;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        //padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white)),
        child: Center(child: widget),
      ),
    );
  }
}
