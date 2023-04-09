import 'package:flutter/material.dart';

class AppIconHeader extends StatelessWidget {
  const AppIconHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: SizedBox(
        width: 163,
        height: 150,
        child: Image.asset(
          'assets/images/logo.png',
        ),
      ),
    );
  }
}
