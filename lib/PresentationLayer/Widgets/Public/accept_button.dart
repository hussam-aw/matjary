import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';

// ignore: must_be_immutable
class AcceptButton extends StatelessWidget {
  AcceptButton(
      {super.key,
      required this.text,
      this.style = acceptButtonStyle,
      this.backgroundColor = UIColors.primary,
      this.textStyle = UITextStyle.boldMeduim,
      required this.onPressed,
      this.isLoading = false});

  final String text;
  final ButtonStyle style;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Function() onPressed;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: style.copyWith(
          backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading)
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: loadingItem(isWhite: true),
                ),
              ),
            Expanded(
              child: Text(
                text,
                textAlign: isLoading ? TextAlign.right : TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
          ],
        ));
  }
}
