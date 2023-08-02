import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/pdf_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/DataAccesslayer/Models/account_statement.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Order/order_print_widget.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/AccountStatements/account_movement_list.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/AccountStatements/account_statement_header.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/AccountStatements/account_statement_print_widget.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/divider.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class AccountStatementPrintScreen extends StatelessWidget {
  AccountStatementPrintScreen({super.key});

  final accountController = Get.find<AccountController>();
  final pdfController = Get.put(PdfController());
  Account account = Get.arguments['account'];
  AccountStatement? accountStatement = Get.arguments['accountStatement'];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                spacerHeight(height: 70),
                const PageTitle(
                  title: 'كشف حساب',
                  titleColor: UIColors.printText,
                ),
                spacerHeight(height: 22),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AccountStatementHeader(
                        accountName: account.name,
                        accountType: accountController
                            .convertAccountTypeToString(account.type),
                        accountImage: 'assets/images/user.png',
                        textColor: UIColors.printText,
                      ),
                      spacerHeight(height: 22),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          accountStatement!.total.toString(),
                          style: UITextStyle.boldHuge.copyWith(
                            color: UIColors.printText,
                          ),
                        ),
                      ),
                      spacerHeight(),
                      const divider(thickness: 1),
                      spacerHeight(height: 22),
                      const SectionTitle(
                        title: 'حركة الحساب',
                        titleColor: UIColors.printText,
                      ),
                      spacerHeight(),
                      Expanded(
                        child: AccountMovementList(
                          statements: accountStatement!.statements,
                          screenMode: 'print',
                        ),
                      ),
                    ],
                  ),
                ),
                spacerHeight(),
                AcceptIconButton(
                  text: const Text('حفظ pdf', style: UITextStyle.boldMeduim),
                  icon: const Icon(FontAwesomeIcons.solidFloppyDisk),
                  center: true,
                  onPressed: () async {
                    await pdfController.saveToPdfFile(
                      fileName:
                          'كشف حساب ${accountsController.getAccountName(account.id)}',
                      widgetList: await buildAccountStatementPrintWidget(
                          account, accountStatement!),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
