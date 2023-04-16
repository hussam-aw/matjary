import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/account_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class ChooseAccountScreen extends StatelessWidget {
  ChooseAccountScreen({super.key});

  final AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'إختيار حساب'),
                spacerHeight(),
                TextFormField(
                  controller: TextEditingController(),
                  textAlign: TextAlign.center,
                  decoration: normalTextFieldStyle.copyWith(
                    hintText: 'قم بالبحث عن اسم الحساب أو اختر من القائمة',
                  ),
                ),
                spacerHeight(height: 20),
                Expanded(
                  child: Obx(
                    () => accountController.isLoadingAccounts.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return AccountBox(
                                  accountName:
                                      accountController.accounts[index].name);
                            },
                            separatorBuilder: (context, index) {
                              return spacerHeight();
                            },
                            itemCount: accountController.accounts.length,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
