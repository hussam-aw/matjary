import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.acceptButton,
  });

  final String title;
  final Widget acceptButton;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        actions: [
          acceptButton,
        ],
      ),
    );
  }
}
