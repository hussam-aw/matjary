import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/custom_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/add_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class ChooseAccountScreen extends StatelessWidget {
  ChooseAccountScreen({super.key});

  final AccountsController accountsController = Get.find<AccountsController>();
  final ListSearchController searchController = Get.put(ListSearchController());

  String? screenMode = Get.arguments['mode'];
  String? accountStyle = Get.arguments['style'];
  var accounts = Get.arguments['accounts'];

  Widget buildAccountsList(accountList) {
    return accountList.isEmpty
        ? Center(
            child: Text(
              'لا يوجد حسابات',
              style: UITextStyle.normalBody.copyWith(
                color: UIColors.normalText,
              ),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return screenMode == null
                  ? CustomBox(
                      title: accountList[index].name,
                      onTap: () {
                        Get.toNamed(AppRoutes.createEditAccountScreen,
                            arguments: accountList[index]);
                      },
                    )
                  : NormalBox(
                      title: accountList[index].name,
                      onTap: () {
                        Get.back(result: accountList[index]);
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
    searchController.list = accounts;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          Get.back(result: null);
          return false;
        },
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
                  SearchTextField(
                    hintText: 'قم بالبحث عن اسم الحساب أو اختر من القائمة',
                    onChanged: (value) {
                      searchController.searchText = value;
                      searchController.search();
                    },
                  ),
                  spacerHeight(height: 20),
                  Expanded(
                    child: Obx(
                      () {
                        if (accountsController.isLoadingAccounts.value) {
                          return Center(
                            child: loadingItem(width: 100, isWhite: true),
                          );
                        }
                        // accountsController
                        //     .getAccountsBasedOnStyle(accountStyle);

                        accounts =
                            accountsController.getAccountsList(accountStyle);
                        return RefreshIndicator(
                          onRefresh: () async =>
                              await accountsController.getAccounts(),
                          child: GetBuilder(
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: AddButton(
            backgroundColor: UIColors.primary,
            iconColor: UIColors.white,
            onPressed: () {
              Get.toNamed(AppRoutes.createEditAccountScreen);
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}
