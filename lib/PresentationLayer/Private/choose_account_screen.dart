import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/custom_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class ChooseAccountScreen extends StatelessWidget {
  ChooseAccountScreen({super.key});

  final AccountController accountController = Get.put(AccountController());
  final HomeController homeController = Get.find<HomeController>();
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    searchController.list = homeController.accounts;
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
                                  ? ListView.separated(
                                      itemBuilder: (context, index) {
                                        return CustomBox(
                                          title: homeController
                                              .accounts[index].name,
                                          editOnPressed: () {
                                            Get.toNamed(
                                                AppRoutes
                                                    .createEditAccountScreen,
                                                arguments: homeController
                                                    .accounts[index]);
                                          },
                                          deleteDialogTitle:
                                              'هل تريد بالتأكيد حذف الحساب؟',
                                          deleteOnPressed: () {
                                            accountController.deleteAccount(
                                                homeController
                                                    .accounts[index].id);
                                            Get.back();
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return spacerHeight();
                                      },
                                      itemCount: homeController.accounts.length,
                                    )
                                  : Obx(() {
                                      return searchController
                                              .searchLoading.value
                                          ? Center(
                                              child: loadingItem(),
                                            )
                                          : ListView.separated(
                                              itemBuilder: (context, index) {
                                                return CustomBox(
                                                  title: searchController
                                                      .filteredList[index].name,
                                                  editOnPressed: () {
                                                    Get.toNamed(
                                                        AppRoutes
                                                            .createEditAccountScreen,
                                                        arguments:
                                                            homeController
                                                                    .accounts[
                                                                index]);
                                                  },
                                                  deleteDialogTitle:
                                                      'هل تريد بالتأكيد حذف الحساب؟',
                                                  deleteOnPressed: () {
                                                    accountController
                                                        .deleteAccount(
                                                            homeController
                                                                .accounts[index]
                                                                .id);
                                                    Get.back();
                                                  },
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return spacerHeight();
                                              },
                                              itemCount: searchController
                                                  .filteredList.length,
                                            );
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
