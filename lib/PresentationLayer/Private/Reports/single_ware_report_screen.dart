import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/reports_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/ware_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_details_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_titles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class SingleWareReportScreen extends StatelessWidget {
  SingleWareReportScreen({super.key});

  ReportsController reportsController = Get.put(ReportsController());
  Ware ware = Get.arguments;

  @override
  Widget build(BuildContext context) {
    reportsController.getWareReports(ware.id);
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
                TableTitles(
                  isDecorated: true,
                  firstColumnTitle: 'المنتج',
                  secondColumnTitle: '',
                  thirdColumnTitle: '',
                  fourthColumnTitle: 'الكمية',
                ),
                spacerHeight(height: 22),
                Expanded(
                  flex: 7,
                  child: Obx(() {
                    return reportsController.isloading.value
                        ? Center(child: loadingItem(width: 100, isWhite: true))
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return TableDetailsItem(
                                firstColumnItem: reportsController
                                    .wareReports[index].product.name,
                                secondColumnItem: '',
                                thirdColumnItem: '',
                                fourthColumnItem: reportsController
                                    .wareReports[index].quantity
                                    .toString(),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                spacerHeight(height: 10),
                            itemCount: reportsController.wareReports.length,
                          );
                  }),
                ),
                AccetpIconButton(
                  text: const Text('حفظ pdf', style: UITextStyle.boldMeduim),
                  icon: const Icon(FontAwesomeIcons.solidFloppyDisk),
                  center: true,
                  backgroundColor: UIColors.primary,
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
