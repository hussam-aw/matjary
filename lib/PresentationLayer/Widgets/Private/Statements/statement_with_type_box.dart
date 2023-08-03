import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/earn_expense_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/statement_with_type.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/statement_type_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class StatementWithTypeBox extends StatelessWidget {
  StatementWithTypeBox({super.key, required this.statement});

  final earnExpenseScreenController = Get.put(EarnExapenseScreenController());
  final StatementWithType statement;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: UIColors.containerBackground,
        borderRadius: raduis15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatementTypeBox(
            statementTypeIcon: earnExpenseScreenController
                .getStatementTypeIcon(statement.type),
            statementType:
                earnExpenseScreenController.getStatementType(statement.type),
            onTap: () {
              Get.toNamed(
                AppRoutes.createEarnExpenseScreen,
                arguments: statement,
              );
            },
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statement.amount.toString(),
                    style: UITextStyle.boldBody,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                  ),
                  spacerHeight(height: 12),
                  Text(
                    'البيان: ${statement.statement}',
                    style: UITextStyle.normalSmall,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                  ),
                  spacerHeight(height: 8),
                  Text(
                    statement.getDateString(statement.date),
                    softWrap: true,
                    style: UITextStyle.normalSmall.copyWith(
                      color: UIColors.titleNoteText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
