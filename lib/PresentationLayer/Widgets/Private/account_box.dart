import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';

class AccountBox extends StatelessWidget {
  AccountBox({super.key, required this.account});

  final Account account;
  final AccountController accountController = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: const BoxDecoration(
        color: UIColors.containerBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            account.name,
            style: UITextStyle.normalMeduim.copyWith(
              color: UIColors.lightNormalText,
            ),
          ),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.edit,
                  color: UIColors.white,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.createEditAccountScreen,
                      arguments: account);
                },
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.delete,
                    color: UIColors.white,
                  ),
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: Text('هل تريد بالتأكيد حذف الحساب؟'),
                        actions: [
                          AcceptButton(
                            text: 'حذف',
                            backgroundColor: UIColors.red,
                            onPressed: () {
                              accountController.deleteAccount(account.id);
                              Get.back();
                            },
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
