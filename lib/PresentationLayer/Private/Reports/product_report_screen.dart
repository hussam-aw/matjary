import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class ProductReportScreen extends StatelessWidget {
  const ProductReportScreen({super.key});

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
              children: [
                const PageTitle(title: 'تقرير جرد بضاعة'),
                spacerHeight(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: AcceptButton(
                          text: 'جرد مستودع',
                          backgroundColor: UIColors.containerBackground,
                          onPressed: () {
                            Get.toNamed(AppRoutes.createWareReportScreen);
                          },
                        ),
                      ),
                    ),
                    spacerWidth(),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: AcceptButton(
                          text: 'جرد منتج',
                          backgroundColor: UIColors.containerBackground,
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.chooseProductScreen,
                              arguments: 'selection',
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
