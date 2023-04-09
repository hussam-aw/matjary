import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';

class PrimaryLine extends StatelessWidget {
  const PrimaryLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 8,
      color: UIColors.primary,
    );
  }
}