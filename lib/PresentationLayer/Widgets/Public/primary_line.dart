import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';

class PrimaryLine extends StatelessWidget {
  const PrimaryLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      color: UIColors.primary,
    );
  }
}
