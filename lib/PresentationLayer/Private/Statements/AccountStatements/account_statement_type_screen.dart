// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/account_statement_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/account_statement_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/AccountStatements/account_statement_header.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class AccountStatementTypeScreen extends StatelessWidget {
  AccountStatementTypeScreen({super.key});

  final accountController = Get.find<AccountController>();
  final accountStatementScreenController =
      Get.put(AccountStatementScreenController());
  final accountStatementController = Get.find<AccountStatementController>();
  Account? account = Get.arguments;

  @override
  Widget build(BuildContext context) {
    accountStatementController.setAccountId(account!.id);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const PageTitle(title: 'كشف حساب'),
                      spacerHeight(height: 22),
                      AccountStatementHeader(
                        accountName: account!.name,
                        accountType: accountController
                            .convertAccountStyleToString(account!.style),
                        accountImage: account!.avatar.toString(),
                      ),
                      spacerHeight(height: 22),
                      Obx(() {
                        return CustomRadioGroup(
                          height: 220,
                          displayInGrid: true,
                          scrollDirection: Axis.horizontal,
                          childAspectRatio: .7,
                          items: accountStatementScreenController
                              .accountStatementFilterTypes
                              .map(
                                (filterType) => RadioButtonItem(
                                  onTap: () {
                                    accountStatementScreenController
                                        .setAccountStatementType(filterType);
                                    accountStatementController
                                        .setAccountStatementFilterType(
                                            accountStatementScreenController
                                                    .accountStatementTypes[
                                                filterType]);
                                  },
                                  isSelected: accountStatementScreenController
                                      .accountStatementFilterTypesSelection
                                      .value[filterType]!,
                                  borderExist: true,
                                  text: filterType,
                                  style: UITextStyle.boldMeduim,
                                ),
                              )
                              .toList(),
                        );
                      }),
                    ],
                  ),
                ),
                Obx(() {
                  return AcceptButton(
                    text: 'كشف حساب',
                    onPressed: () async {
                      await accountStatementController
                          .getAccountStatementBasedOnType();
                      Get.toNamed(
                        AppRoutes.accountStatementScreen,
                        arguments: {
                          'account': account,
                          'accountStatement':
                              accountStatementController.accountStatement,
                        },
                      );
                    },
                    isLoading: accountStatementController
                        .isLoadingAccountStatement.value,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
