import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Create/create_bottom_sheet.dart';
import 'package:matjary/PresentationLayer/Widgets/Home/customer_account_list_tile.dart';
import 'package:matjary/PresentationLayer/Widgets/Home/invoice_container.dart';
import 'package:matjary/PresentationLayer/Widgets/Home/order_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/bottom_navigation_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          decoration: const BoxDecoration(
                            color: UIColors.containerBackground,
                            borderRadius: radius19,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.moneyCheckDollar,
                                      color: UIColors.primary,
                                      size: 50,
                                    ),
                                    spacerWidth(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'رصيد الصندوق',
                                          style: UITextStyle.normalSmall,
                                        ),
                                        spacerHeight(height: 10),
                                        const Text(
                                          '1.500.000',
                                          style: UITextStyle.boldHeading,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OrderIconButton(
                                      onTap: () {},
                                      title: 'استلام',
                                      icon: FontAwesomeIcons.solidCircleDown,
                                    ),
                                    spacerWidth(width: 10),
                                    OrderIconButton(
                                      onTap: () {},
                                      title: 'ارسال',
                                      icon: FontAwesomeIcons.solidCircleUp,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      spacerHeight(height: 20),
                      Expanded(
                        child: Row(
                          children: [
                            InovoiceContainer(
                              invoiceType: 'فواتير المشتريات',
                              invoiceAmount: '20',
                            ),
                            spacerWidth(width: 40),
                            InovoiceContainer(
                              invoiceType: 'فواتير المبيعات',
                              invoiceAmount: '20',
                              backgroundColor: UIColors.primary,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(top: 30, left: 35, right: 35),
                  decoration: const BoxDecoration(
                    color: UIColors.containerBackground,
                    borderRadius: raduis32top,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'حسابات العملاء',
                        style: UITextStyle.boldBody,
                      ),
                      spacerHeight(height: 10),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomerAccountListTile(
                              customerName: 'محمد سمير',
                              customerImage: 'assets/images/user.png',
                              customerStatus: 'زبون',
                              customerBalance: '1.500.000',
                            );
                          },
                          separatorBuilder: (context, index) {
                            return spacerHeight(height: 25);
                          },
                          itemCount: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        floatingActionButton: CustomIconButton(
          icon: const Icon(
            size: 45,
            FontAwesomeIcons.plus,
            color: UIColors.primary,
          ),
          onPressed: () {
            Get.bottomSheet(const CreateBottomSheet());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
