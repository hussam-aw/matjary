// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class InovoiceContainer extends StatelessWidget {
  InovoiceContainer({
    super.key,
    required this.invoiceType,
    required this.invoiceCountWidget,
    required this.onTap,
    this.backgroundColor,
  });

  final String invoiceType;
  final Widget invoiceCountWidget;
  final Function() onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: backgroundColor ?? UIColors.containerBackground,
            borderRadius: radius19,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  invoiceType,
                  softWrap: true,
                  //overflow: TextOverflow.ellipsis,
                  style: UITextStyle.normalSmall,
                ),
              ),
              Expanded(child: invoiceCountWidget),
            ],
          ),
        ),
      ),
    );
  }
}
