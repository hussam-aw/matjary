import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/primary_line.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.mainBackground,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
      bottomSheet: const PrimaryLine(),
    );
  }
}
