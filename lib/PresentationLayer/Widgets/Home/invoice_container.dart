import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class InovoiceContainer extends StatelessWidget {
  InovoiceContainer({
    super.key,
    required this.invoiceType,
    required this.invoiceCountWidget,
    this.backgroundColor,
  });

  String invoiceType;
  Widget invoiceCountWidget;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: backgroundColor ?? UIColors.containerBackground,
          borderRadius: radius19,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              invoiceType,
              overflow: TextOverflow.ellipsis,
              style: UITextStyle.normalSmall,
            ),
            spacerHeight(),
            invoiceCountWidget,
          ],
        ),
      ),
    );
  }
}
