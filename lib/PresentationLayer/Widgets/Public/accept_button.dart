import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';

// ignore: must_be_immutable
class AcceptButton extends StatelessWidget {
  AcceptButton(
      {super.key,
      required this.text,
      this.style = acceptButtonStyle,
      required this.onPressed,
      this.isLoading = false});

  final String text;
  final ButtonStyle style;
  final Function() onPressed;
  bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading) loadingItem(isWhite: true),
            Text(
              text,
              style: UITextStyle.boldMeduim,
            ),
          ],
        ));
  }
}
