import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account_movement.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/AccountStatements/account_movement_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class AccountMovementList extends StatelessWidget {
  const AccountMovementList({
    super.key,
    required this.statements,
    this.screenMode,
  });

  final List<AccountMovement> statements;
  final String? screenMode;

  @override
  Widget build(BuildContext context) {
    return statements.isEmpty
        ? Center(
            child: Text(
              'لا يوجد قيود',
              style: UITextStyle.normalBody.copyWith(
                color: screenMode == 'print'
                    ? UIColors.printText
                    : UIColors.normalText,
              ),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return AccountMovementBox(
                accountMovement: statements[index],
                screenMode: screenMode,
              );
            },
            separatorBuilder: (context, index) {
              return spacerHeight();
            },
            itemCount: statements.length,
          );
  }
}
