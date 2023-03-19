import 'package:flutter/material.dart';

class spacerHeight extends StatelessWidget {
  spacerHeight({super.key, this.height = 14.0});

  double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
