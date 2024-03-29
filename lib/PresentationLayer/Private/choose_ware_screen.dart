import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/add_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class ChooseWareScreen extends StatelessWidget {
  ChooseWareScreen({super.key});

  final WaresController waresController = Get.find<WaresController>();
  final ListSearchController searchController = Get.put(ListSearchController());

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
              return NormalBox(
                title: wareList[index].name,
                onTap: () {
                  if (screenMode == 'reportSelection') {
                    Get.toNamed(AppRoutes.singleWareReportScreen,
                        arguments: wareList[index]);
                  } else if (screenMode == null) {
                    Get.toNamed(AppRoutes.createEditWareScreen,
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
    searchController.setSearchList(waresController.wares);
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
                const PageTitle(title: 'المستودعات'),
                spacerHeight(),
                SearchTextField(
                  hintText: 'قم بالبحث عن اسم المستودع أو اختر من القائمة',
                  onChanged: (value) {
                    searchController.search(value);
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
