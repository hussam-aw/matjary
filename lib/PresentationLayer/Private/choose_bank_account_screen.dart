import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/custom_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class ChooseBankAccountScreen extends StatelessWidget {
  ChooseBankAccountScreen({super.key});

  final AccountController accountController = Get.put(AccountController());
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'إختيار حساب صندوق'),
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
                    () => homeController.isLoadingAccounts.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return CustomBox(
                                title: homeController.bankAccounts[index].name,
                                editOnPressed: () {
                                  Get.toNamed(AppRoutes.createEditAccountScreen,
                                      arguments:
                                          homeController.bankAccounts[index]);
                                },
                                deleteDialogTitle:
                                    'هل تريد بالتأكيد حذف الحساب؟',
                                deleteOnPressed: () {
                                  accountController.deleteAccount(
                                      homeController.bankAccounts[index].id);
                                  Get.back();
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return spacerHeight();
                            },
                            itemCount: homeController.bankAccounts.length,
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
