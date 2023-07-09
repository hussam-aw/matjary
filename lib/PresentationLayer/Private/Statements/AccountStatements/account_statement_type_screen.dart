import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

// ignore: must_be_immutable
class AccountStatementTypeScreen extends StatelessWidget {
  AccountStatementTypeScreen({super.key});

  final accountController = Get.find<AccountController>();
  Account? account = Get.arguments;

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
                    children: [
                      const PageTitle(title: 'كشف حساب'),
                      spacerHeight(height: 22),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          ),
                          spacerWidth(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  account!.name,
                                  softWrap: true,
                                  style: UITextStyle.normalMeduim.copyWith(
                                    color: UIColors.lightNormalText,
                                  ),
                                ),
                                spacerHeight(),
                                Text(
                                  accountController.convertAccountStyleToString(
                                      account!.type),
                                  softWrap: true,
                                  style: UITextStyle.normalBody.copyWith(
                                    color: UIColors.lightNormalText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      spacerHeight(height: 22),
                      CustomRadioGroup(
                        height: 220,
                        displayInGrid: true,
                        scrollDirection: Axis.horizontal,
                        childAspectRatio: .7,
                        items: [
                          RadioButtonItem(
                            onTap: () {},
                            isSelected: true,
                            borderExist: true,
                            text: 'عن كامل المدة',
                            style: UITextStyle.boldMeduim,
                          ),
                          RadioButtonItem(
                            onTap: () {},
                            borderExist: true,
                            text: 'آخر أسبوع',
                            style: UITextStyle.boldMeduim,
                          ),
                          RadioButtonItem(
                            onTap: () {},
                            borderExist: true,
                            text: 'بين تاريخين',
                            style: UITextStyle.boldMeduim,
                          ),
                          RadioButtonItem(
                            onTap: () {},
                            borderExist: true,
                            text: 'آخر شهر',
                            style: UITextStyle.boldMeduim,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AcceptButton(
                  text: 'كشف حساب',
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
