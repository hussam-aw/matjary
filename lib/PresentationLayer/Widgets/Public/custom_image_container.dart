import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_styles.dart';

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer({super.key, required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: raduis15,
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
    );
  }
}
