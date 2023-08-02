import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';

void buildCustomBottomSheet(Widget w) {
  Get.bottomSheet(Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      height: Get.width * .6,
      padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
      decoration: const BoxDecoration(
        borderRadius: raduis32top,
        color: UIColors.white,
      ),
      child: w,
    ),
  ));
}
