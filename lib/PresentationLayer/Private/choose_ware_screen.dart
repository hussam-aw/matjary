import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/ware_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
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

class ChooseWareScreen extends StatelessWidget {
  ChooseWareScreen({super.key});

  final WaresController waresController = Get.find<WaresController>();
  final SearchController searchController = Get.put(SearchController());
  late var controller;

  String? screenMode = Get.arguments['mode'];

  Widget buildWareList(wareList) {
    return wareList.isEmpty
        ? Center(
            child: Text(
              'لا يوجد مستودعات',
              style: UITextStyle.normalBody.copyWith(
                color: UIColors.normalText,
              ),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return screenMode == null
                  ? CustomBox(
                      title: wareList[index].name,
                      editOnPressed: () {
                        Get.toNamed(AppRoutes.createEditWareScreen,
                            arguments: wareList[index]);
                      },
                      deleteDialogTitle: 'هل تريد بالتأكيد حذف المستودع؟',
                      deleteOnPressed: () {
                        controller.deleteWare(wareList[index].id);
                        Get.back();
                      },
                    )
                  : NormalBox(
                      title: wareList[index].name,
                      onTap: () {
                        if (screenMode == 'reportSelection') {
                          Get.toNamed(AppRoutes.singleWareReportScreen,
                              arguments: wareList[index]);
                        } else {
                          Get.back(result: wareList[index]);
                        }
                      },
                    );
            },
            separatorBuilder: (context, index) {
              return spacerHeight();
            },
            itemCount: wareList.length,
          );
  }

  @override
  Widget build(BuildContext context) {
    searchController.list = waresController.wares;
    if (screenMode == null) {
      controller = Get.put(WareController());
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
                const PageTitle(title: 'إختيار مستودع'),
                spacerHeight(),
                SearchTextField(
                  hintText: 'قم بالبحث عن اسم المستودع أو اختر من القائمة',
                  onChanged: (value) {
                    searchController.searchText = value;
                    searchController.search();
                  },
                ),
                spacerHeight(height: 20),
                Expanded(
                  child: Obx(
                    () => waresController.isLoadingWares.value
                        ? Center(
                            child: loadingItem(width: 100, isWhite: true),
                          )
                        : RefreshIndicator(
                            onRefresh: () async =>
                                await waresController.getWares(),
                            child: GetBuilder(
                              init: searchController,
                              builder: (context) {
                                return searchController.searchText.isEmpty
                                    ? buildWareList(waresController.wares)
                                    : Obx(
                                        () {
                                          return searchController
                                                  .searchLoading.value
                                              ? Center(
                                                  child: loadingItem(
                                                      width: 100,
                                                      isWhite: true),
                                                )
                                              : buildWareList(searchController
                                                  .filteredList);
                                        },
                                      );
                              },
                            ),
                          ),
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
            Get.toNamed(AppRoutes.createEditWareScreen);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
