import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';

void buildCustomBottomSheet(Widget w) {
  Get.bottomSheet(Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      height: Get.width * .5,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: raduis32top,
        color: UIColors.white,
      ),
      child: w,
    ),
  ));
}
