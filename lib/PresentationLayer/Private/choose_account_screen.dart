import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/statement_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/account.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/custom_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class ChooseAccountScreen extends StatelessWidget {
  ChooseAccountScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final SearchController searchController = Get.put(SearchController());
  late var controller;

  String? screenMode = Get.arguments;
  late List<Account> accounts;

  Widget buildAccountsList(accountList) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return screenMode == null
            ? CustomBox(
                title: accountList[index].name,
                editOnPressed: () {
                  Get.toNamed(AppRoutes.createEditAccountScreen,
                      arguments: accountList[index]);
                },
                deleteDialogTitle: 'هل تريد بالتأكيد حذف الحساب؟',
                deleteOnPressed: () {
                  controller.deleteAccount(accountList[index].id);
                  Get.back();
                },
              )
            : NormalBox(
                title: accountList[index].name,
                onTap: () {
                  controller.setAccountBasedOnType(
                      accountList[index].name, screenMode);
                },
              );
      },
      separatorBuilder: (context, index) {
        return spacerHeight();
      },
      itemCount: accountList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    accounts = homeController.accounts;
    searchController.list = accounts;
    if (screenMode == null) {
      controller = Get.put(AccountController());
    } else {
      controller = Get.find<StatementController>();
    }
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
                const PageTitle(title: 'إختيار حساب'),
                spacerHeight(),
                TextFormField(
                  textAlign: TextAlign.center,
                  style: UITextStyle.normalBody,
                  decoration: normalTextFieldStyle.copyWith(
                    hintText: 'قم بالبحث عن اسم الحساب أو اختر من القائمة',
                  ),
                  onChanged: (value) {
                    searchController.searchText = value;
                    searchController.search();
                  },
                ),
                spacerHeight(height: 20),
                Expanded(
                  child: Obx(
                    () => homeController.isLoadingAccounts.value
                        ? Center(
                            child: loadingItem(width: 100, isWhite: true),
                          )
                        : GetBuilder(
                            init: searchController,
                            builder: (context) {
                              return searchController.searchText.isEmpty
                                  ? buildAccountsList(accounts)
                                  : Obx(() {
                                      return searchController
                                              .searchLoading.value
                                          ? Center(
                                              child: loadingItem(
                                                  width: 100, isWhite: true),
                                            )
                                          : buildAccountsList(
                                              searchController.filteredList);
                                    });
                            }),
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
