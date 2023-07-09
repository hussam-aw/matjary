import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/account_movement_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/account_statement_header.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/divider.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class AccountStatementScreen extends StatelessWidget {
  AccountStatementScreen({super.key});

  final accountController = Get.find<AccountController>();
  Account? account = Get.arguments;

  Widget buildStatementList(statementList) {
    return statementList.isEmpty
        ? Center(
            child: Text(
              'لا يوجد قيود',
              style: UITextStyle.normalBody.copyWith(
                color: UIColors.normalText,
              ),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return AccountMovementBox();
            },
            separatorBuilder: (context, index) {
              return spacerHeight();
            },
            itemCount: 30,
          );
  }

  @override
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PageTitle(title: 'كشف حساب'),
                      spacerHeight(height: 22),
                      AccountStatementHeader(
                        accountName: account!.name,
                        accountType: accountController
                            .convertAccountTypeToString(account!.type),
                        accountImage: 'assets/images/user.png',
                      ),
                      spacerHeight(height: 22),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '150000',
                          style: UITextStyle.boldHuge.copyWith(
                            color: UIColors.primary,
                          ),
                        ),
                      ),
                      spacerHeight(),
                      const divider(thickness: 1),
                      spacerHeight(height: 22),
                      const SectionTitle(title: 'حركة الحساب'),
                      spacerHeight(),
                      Expanded(
                        child: buildStatementList(
                          [''],
                        ),
                      ),
                    ],
                  ),
                ),
                spacerHeight(),
                AccetpIconButton(
                  text: const Text('حفظ pdf', style: UITextStyle.boldMeduim),
                  icon: const Icon(FontAwesomeIcons.solidFloppyDisk),
                  center: true,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
