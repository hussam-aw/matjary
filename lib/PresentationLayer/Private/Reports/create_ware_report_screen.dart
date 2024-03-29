import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class CreateWareReportScreen extends StatelessWidget {
  CreateWareReportScreen({super.key});

  final WaresController waresController = Get.find<WaresController>();
  final ListSearchController searchController = Get.put(ListSearchController());

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
                  Get.toNamed(AppRoutes.singleWareReportScreen,
                      arguments: wareList[index]);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageTitle(title: 'تقرير جرد مستودعات'),
                spacerHeight(height: 22),
                const SectionTitle(title: 'إنشاء جرد لكل المستودعات'),
                spacerHeight(),
                AcceptButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.waresReportScreen);
                  },
                  backgroundColor: UIColors.primary,
                  text: 'جرد شامل',
                ),
                spacerHeight(height: 22),
                const SectionTitle(title: 'أو إختر المستودع'),
                spacerHeight(),
                SearchTextField(
                  hintText: 'قم بالبحث عن اسم المستودع  أو إختر من القائمة',
                  onChanged: (value) {
                    searchController.search(value);
                  },
                ),
                spacerHeight(),
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
      ),
    );
  }
}
