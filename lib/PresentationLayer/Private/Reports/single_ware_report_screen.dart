import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_titles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class SingleWareReportScreen extends StatelessWidget {
  SingleWareReportScreen({super.key});

  Ware ware = Get.arguments;

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
