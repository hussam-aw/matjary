import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/reports_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_details_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_titles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class WaresReportScreen extends StatelessWidget {
  WaresReportScreen({super.key});

  final reportsController = Get.put(ReportsController());

  @override
  Widget build(BuildContext context) {
    reportsController.getAllProductsReports();
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
                const PageTitle(title: 'جرد البضاعة الشامل'),
                spacerHeight(height: 22),
                const TableTitles(
                  isDecorated: true,
                  firstColumnTitle: 'المنتج',
                  secondColumnTitle: '',
                  thirdColumnTitle: 'الكميات',
                  fourthColumnTitle: 'التفاصيل',
                ),
                spacerHeight(),
                Expanded(
                  flex: 7,
                  child: Obx(() {
                    return reportsController.isloading.value
                        ? Center(child: loadingItem(width: 100, isWhite: true))
                        : reportsController.productsReports.isEmpty
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
                                  return TableDetailsItem(
                                    firstColumnItem: reportsController
                                        .productsReports[index].productName,
                                    thirdColumnItem: reportsController
                                        .productsReports[index].quantity
                                        .toString(),
                                    fourthColumnItem: InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.info,
                                        size: 30,
                                        color: UIColors.white,
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    spacerHeight(height: 10),
                                itemCount:
                                    reportsController.productsReports.length,
                              );
                  }),
                ),
                spacerHeight(height: 22),
                AccetpIconButton(
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
