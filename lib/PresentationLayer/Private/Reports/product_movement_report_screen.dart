// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/reports_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_details_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_titles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/divider.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class ProductMovementReportScreen extends StatelessWidget {
  ProductMovementReportScreen({super.key});

  final reportsController = Get.put(ReportsController());
  Product product = Get.arguments['product'];
  String? wareName = Get.arguments['wareName'];

  @override
  Widget build(BuildContext context) {
    reportsController.getProductMovementReport(product.id, wareName);
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
                const PageTitle(title: 'كشف حركة المنتج'),
                spacerHeight(),
                SectionTitle(
                  title: product.name,
                  titleColor: UIColors.white,
                  textStyle: UITextStyle.normalMeduim,
                ),
                spacerHeight(height: 22),
                const TableTitles(
                  isDecorated: true,
                  titles: ["الكمية", "البيان", "", "", "المستودع"],
                ),
                spacerHeight(height: 22),
                Expanded(
                  flex: 7,
                  child: Obx(() {
                    return reportsController
                            .isLoadingProductMovementReport.value
                        ? Center(child: loadingItem(width: 100, isWhite: true))
                        : reportsController.productMovements.isEmpty
                            ? Center(
                                child: Text(
                                  'لا يوجد منتجات',
                                  style: UITextStyle.normalBody.copyWith(
                                    color: UIColors.normalText,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return TableDetailsItem(
                                          rowCells: {
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                reportsController
                                                            .productMovements[
                                                                index]
                                                            .movement ==
                                                        "outside"
                                                    ? const Icon(
                                                        FontAwesomeIcons
                                                            .arrowDown,
                                                        color: UIColors.red,
                                                        size: 10,
                                                      )
                                                    : const Icon(
                                                        FontAwesomeIcons
                                                            .arrowUp,
                                                        color: UIColors.success,
                                                        size: 10,
                                                      ),
                                                Text(
                                                  reportsController
                                                      .productMovements[index]
                                                      .quantity
                                                      .toString(),
                                                  style: UITextStyle.boldBody,
                                                )
                                              ],
                                            ): 1,
                                            reportsController
                                                .productMovements[index]
                                                .statement
                                                .toString(): 4,
                                            reportsController
                                                .productMovements[index].ware
                                                .toString(): 1
                                          },
                                          /*  firstColumnItem: reportsController
                                              .productMovements[index].quantity
                                              .toString(),
                                          secondColumnItem: reportsController
                                              .productMovements[index].statement
                                              .toString(),
                                          //thirdColumnItem: '',
                                          fourthColumnItem:reportsController
                                              .productMovements[index].ware
                                              .toString() , */
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          spacerHeight(height: 10),
                                      itemCount: reportsController
                                          .productMovements.length,
                                    ),
                                  ),
                                  spacerHeight(),
                                  Center(
                                    child: Text(
                                      'الجرد الحالي: ${reportsController.productMovements.length}',
                                      style: UITextStyle.boldBody,
                                    ),
                                  ),
                                ],
                              );
                  }),
                ),
                const divider(thickness: 1),
                spacerHeight(),
                AcceptIconButton(
                  text: const Text('حفظ pdf', style: UITextStyle.boldMeduim),
                  icon: const Icon(FontAwesomeIcons.solidFloppyDisk),
                  center: true,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
