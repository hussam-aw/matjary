import 'package:flutter/material.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account_movement.dart';

class AccountMovementBox extends StatelessWidget {
  const AccountMovementBox({
    super.key,
    required this.accountMovement,
    this.screenMode,
  });

  final AccountMovement accountMovement;
  final String? screenMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: screenMode == 'print'
            ? UIColors.white
            : UIColors.containerBackground,
        borderRadius: raduis15,
        border: Border.all(color: UIColors.containerBorder),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              accountMovement.statement,
              softWrap: true,
              style: UITextStyle.normalBody.copyWith(
                color: screenMode == 'print'
                    ? UIColors.printText
                    : UIColors.lightNormalText,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormatter.getDateString(accountMovement.date),
                  softWrap: true,
                  style: UITextStyle.normalBody.copyWith(
                    color: screenMode == 'print'
                        ? UIColors.printText
                        : UIColors.lightNormalText,
                  ),
                ),
                Text(
                  accountMovement.amount.toString(),
                  softWrap: true,
                  style: UITextStyle.boldHeading.copyWith(
                    color: screenMode == 'print'
                        ? UIColors.printText
                        : UIColors.lightNormalText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
