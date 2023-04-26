import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loadingItem({double width = 40, bool isWhite = false}) {
  return LottieBuilder.asset(
    isWhite
        ? "assets/images/calculator-white.json"
        : "assets/images/calculator.json",
    width: width,
    height: width,
  );
}
