import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class StatementTypeBox extends StatelessWidget {
  const StatementTypeBox({
    super.key,
    required this.statementTypeIcon,
    required this.statementType,
    this.onTap,
  });

  final IconData statementTypeIcon;
  final String statementType;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: onTap,
        child: Container(
          //height: 70,
          decoration: const BoxDecoration(
            color: UIColors.primary,
            borderRadius: raduis10,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Icon(
                    statementTypeIcon,
                    size: 35,
                    color: UIColors.white,
                  ),
                  spacerHeight(),
                  Text(
                    statementType,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                    style: UITextStyle.normalMeduim,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
