import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import '../../../Constants/get_routes.dart';

class AccountOptionsMenu extends StatelessWidget {
  AccountOptionsMenu({super.key, required this.account});

  final accountController = Get.find<AccountController>();
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed(AppRoutes.createEditAccountScreen,
                arguments: account),
            child: Text(
              'تعديل',
              style: UITextStyle.normalHeading.copyWith(
                color: UIColors.menuTitle,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed(
              AppRoutes.accountStatementTypeScreen,
              arguments: account,
            ),
            child: Text(
              'كشف حساب',
              style: UITextStyle.normalHeading.copyWith(
                color: UIColors.menuTitle,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => accountController.pinAccountToHomeScreen(account.id),
            child: Text(
              'تثبيت في الشاشة الرئيسية',
              style: UITextStyle.normalHeading.copyWith(
                color: UIColors.menuTitle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
