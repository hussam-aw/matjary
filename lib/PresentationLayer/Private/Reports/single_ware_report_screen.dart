import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/reports_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_details_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_titles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class SingleWareReportScreen extends StatelessWidget {
  SingleWareReportScreen({super.key});

  ReportsController reportsController = Get.put(ReportsController());
  ProductsController productsController = Get.find<ProductsController>();
  Ware ware = Get.arguments;

  @override
  Widget build(BuildContext context) {
    reportsController.getWareReport(ware.id);
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
                PageTitle(title: 'جرد المستودع : ${ware.name}'),
                spacerHeight(height: 22),
                const TableTitles(
                  isDecorated: true,
                  titles: ["المنتج", "الكمية"],
                ),
                spacerHeight(height: 22),
                Expanded(
                  flex: 7,
                  child: Obx(() {
                    return reportsController.isLoadingWareReport.value
                        ? Center(child: loadingItem(width: 100, isWhite: true))
                        : reportsController.productsWithQuantity.isEmpty
                            ? Center(
                                child: Text(
                                  'لا يوجد تقارير',
                                  style: UITextStyle.normalBody.copyWith(
                                    color: UIColors.normalText,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.productMovementReportScreen,
                                          arguments: {
                                            'product': reportsController
                                                .productsWithQuantity[index]
                                                .product,
                                            'wareName': ware.name
                                          });
                                    },
                                    child: TableDetailsItem(
                                      rowCells: {
                                        reportsController
                                            .productsWithQuantity[index]
                                            .product
                                            .name: 1,
                                        reportsController
                                            .productsWithQuantity[index]
                                            .quantity
                                            .toString(): 1
                                      },
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    spacerHeight(height: 10),
                                itemCount: reportsController
                                    .productsWithQuantity.length,
                              );
                  }),
                ),
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
