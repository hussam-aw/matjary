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

class ChooseBankAccountScreen extends StatelessWidget {
  ChooseBankAccountScreen({super.key});

  final AccountController accountController = Get.put(AccountController());
  final HomeController homeController = Get.find<HomeController>();
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    searchController.list = homeController.bankAccounts;
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
                const PageTitle(title: 'إختيار صندوق'),
                spacerHeight(),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: normalTextFieldStyle.copyWith(
                    hintText: 'قم بالبحث عن اسم الصندوق أو اختر من القائمة',
                  ),
                  onChanged: (value) {
                    searchController.searchText = value;
                    searchController.search();
                  },
                ),
                spacerHeight(height: 20),
                Expanded(
                  child: Obx(
                    () => homeController.isLoadingBankAccounts.value
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
                                              .bankAccounts[index].name,
                                          editOnPressed: () {
                                            Get.toNamed(
                                                AppRoutes
                                                    .createEditAccountScreen,
                                                arguments: homeController
                                                    .bankAccounts[index]);
                                          },
                                          deleteDialogTitle:
                                              'هل تريد بالتأكيد حذف الحساب؟',
                                          deleteOnPressed: () {
                                            accountController.deleteAccount(
                                                homeController
                                                    .bankAccounts[index].id);
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return spacerHeight();
                                      },
                                      itemCount:
                                          homeController.bankAccounts.length,
                                    )
                                  : Obx(() {
                                      return searchController
                                              .searchLoading.value
                                          ? Center(
                                              child: loadingItem(
                                                  width: 100, isWhite: true),
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
                                                            searchController
                                                                    .filteredList[
                                                                index]);
                                                  },
                                                  deleteDialogTitle:
                                                      'هل تريد بالتأكيد حذف الحساب؟',
                                                  deleteOnPressed: () {
                                                    accountController
                                                        .deleteAccount(
                                                            searchController
                                                                .filteredList[
                                                                    index]
                                                                .id);
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
