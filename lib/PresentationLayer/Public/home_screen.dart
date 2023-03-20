import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Home/customer_account_list_tile.dart';
import 'package:matjary/PresentationLayer/Widgets/Home/invoice_container.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/bottom_navigation_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_floating_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(),
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 16),
                          decoration: const BoxDecoration(
                            color: UIColors.containerBackground,
                            borderRadius: radius19,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.fileInvoice,
                                    color: UIColors.primary,
                                    size: 36,
                                  ),
                                  spacerWidth(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          FontAwesomeIcons.solidCircleUp,
                                          size: 32,
                                          color: UIColors.white,
                                        ),
                                      ),
                                      const Text(
                                        'استلام',
                                        style: UITextStyle.normalSmall,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          FontAwesomeIcons.solidCircleDown,
                                          size: 32,
                                          color: UIColors.white,
                                        ),
                                      ),
                                      const Text(
                                        'ارسال',
                                        style: UITextStyle.normalSmall,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        spacerHeight(height: 25),
                        Row(
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
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    width: Get.width,
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
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
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return CustomerAccountListTile(
                                customerName: 'محمد سمير',
                                customerImage: 'assets/images/user.png',
                                customerStatus: 'زبون',
                                customerBalance: '1.500.000',
                              );
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
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        floatingActionButton: const CustomFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
