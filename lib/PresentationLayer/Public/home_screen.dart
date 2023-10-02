import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/profile_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Create/create_bottom_sheet.dart';
import 'package:matjary/PresentationLayer/Widgets/Home/customer_account_list_tile.dart';
import 'package:matjary/PresentationLayer/Widgets/Home/invoice_container.dart';
import 'package:matjary/PresentationLayer/Widgets/Home/order_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/add_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/bottom_navigation_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/divider.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';
import 'package:matjary/PresentationLayer/Widgets/shimmers/amount_shimmer.dart';
import 'package:matjary/PresentationLayer/Widgets/shimmers/customer_list_tile_shimmer.dart';
import 'package:matjary/PresentationLayer/Widgets/shimmers/order_count_shimmer.dart';
import 'package:matjary/main.dart';

import '../../Constants/get_routes.dart';
import '../Widgets/Create/create_menu_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.find<HomeController>();
  final accountsController = Get.find<AccountsController>();
  final accountController = Get.put(AccountController());
  final ordersController = Get.find<OrdersController>();
  final profileController = Get.put(ProfileController());

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: Get.width,
                  child: GetBuilder(
                      init: profileController,
                      builder: (context) {
                        return Text(
                          "مرحباً بك : ${MyApp.appUser!.name}",
                          softWrap: true,
                          style: UITextStyle.boldBody,
                          textAlign: TextAlign.right,
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      AcceptButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.createEditOrderScreen);
                        },
                        textStyle: UITextStyle.boldBody,
                        text: "أنشئ فاتورة جديدة",
                      ),
                      spacerHeight(height: 5),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: Get.width,
                        child: Text(
                          "أو تابع حساباتك المالية ",
                          softWrap: true,
                          style: UITextStyle.normalSmall
                              .apply(color: Colors.white54),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CreateMenuItem(
                              onTap: () async {
                                var account =
                                    await accountsController.selectAccount(
                                        accountsController.accounts, '');
                                if (account != null) {
                                  Get.toNamed(
                                    AppRoutes.accountStatementTypeScreen,
                                    arguments: account,
                                  );
                                }
                              },
                              icon: 'assets/new_icons/account2-ph.png',
                              title: 'كشف حساب',
                              textColor: Colors.white54,
                            ),
                            CreateMenuItem(
                              onTap: () {
                                Get.toNamed(AppRoutes.createEditPaymentScreen,
                                    arguments: {'paymentType': 'مقبوضات'});
                              },
                              icon: 'assets/new_icons/account_ph.png',
                              title: 'دفعة نقدية',
                              textColor: Colors.white54,
                            ),
                            CreateMenuItem(
                              onTap: () {
                                Get.toNamed(AppRoutes.createStatementScreen);
                              },
                              icon: 'assets/new_icons/qeed.png',
                              title: 'قيد محاسبي',
                              textColor: Colors.white54,
                            ),
                            CreateMenuItem(
                              onTap: () {
                                Get.toNamed(AppRoutes.productReportScreen);
                              },
                              icon: 'assets/new_icons/ware_ph.png',
                              title: 'جرد بضاعة',
                              textColor: Colors.white54,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          spacerWidth(width: 120),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'السيولة النقدية',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style:
                                                      UITextStyle.normalSmall,
                                                ),
                                                spacerHeight(height: 10),
                                                Obx(
                                                  () => accountsController
                                                          .isLoadingCashAmount
                                                          .value
                                                      ? const AmountShimmer()
                                                      : Text(
                                                          accountsController
                                                              .cashAmount.value
                                                              .toString(),
                                                          softWrap: true,
                                                          // overflow:
                                                          //     TextOverflow.ellipsis,
                                                          style: UITextStyle
                                                              .boldHeading,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        OrderIconButton(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.createEditPaymentScreen,
                                              arguments: {
                                                'paymentType': 'مقبوضات'
                                              },
                                            );
                                          },
                                          title: 'استلام',
                                          icon:
                                              FontAwesomeIcons.solidCircleDown,
                                        ),
                                        spacerWidth(width: 10),
                                        OrderIconButton(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.createEditPaymentScreen,
                                              arguments: {
                                                'paymentType': 'مدفوعات'
                                              },
                                            );
                                          },
                                          title: 'ارسال',
                                          icon: FontAwesomeIcons.solidCircleUp,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            spacerHeight(height: 20),
                            Row(
                              children: [
                                InovoiceContainer(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.ordersScreen,
                                        arguments: 'مشتريات');
                                  },
                                  invoiceType: 'فواتير المشتريات',
                                  invoiceCountWidget: Obx(() {
                                    return ordersController
                                            .isLoadingPurchaseOrder.value
                                        ? const OrderCountShimmer()
                                        : Text(
                                            ordersController
                                                .purchasesOrders.length
                                                .toString(),
                                            softWrap: true,
                                            //overflow: TextOverflow.ellipsis,
                                            style: UITextStyle.boldHeading
                                                .apply(fontSizeFactor: 1.2),
                                          );
                                  }),
                                ),
                                spacerWidth(width: 40),
                                InovoiceContainer(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.ordersScreen,
                                        arguments: 'بيع للزبائن');
                                  },
                                  invoiceType: 'فواتير المبيعات',
                                  invoiceCountWidget: Obx(() {
                                    return ordersController
                                            .isLoadingSaleOrders.value
                                        ? const OrderCountShimmer()
                                        : Text(
                                            ordersController.salesOrders.length
                                                .toString(),
                                            softWrap: true,
                                            // overflow: TextOverflow.ellipsis,
                                            style: UITextStyle.boldHeading
                                                .apply(fontSizeFactor: 1.2),
                                          );
                                  }),
                                  backgroundColor: UIColors.primary,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 20,
                        child: Image.asset(
                          "assets/new_icons/bank_ph.png",
                          width: 120,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: UIColors.containerBackground,
                      borderRadius: raduis32top,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'الحسابات المثبتة',
                          softWrap: true,
                          style: UITextStyle.boldBody,
                        ),
                        spacerHeight(
                          height: 10,
                        ),
                        divider(
                          thickness: 1,
                          color: UIColors.white.withOpacity(.2),
                        ),
                        spacerHeight(height: 20),
                        Expanded(
                          child: Obx(() {
                            return accountsController
                                    .isLoadingPinnedAccounts.value
                                ? ListView.separated(
                                    itemBuilder: (context, index) {
                                      return const CustomerListTileShimmer();
                                    },
                                    separatorBuilder: (context, index) =>
                                        spacerHeight(height: 25),
                                    itemCount: 5,
                                  )
                                : ListView.separated(
                                    itemBuilder: (context, index) {
                                      return CustomerAccountListTile(
                                        onTap: () {
                                          Get.toNamed(
                                            AppRoutes
                                                .accountStatementTypeScreen,
                                            arguments: accountsController
                                                .pinnedAccounts[index],
                                          );
                                        },
                                        customerName: accountsController
                                            .pinnedAccounts[index].name,
                                        customerImage: accountsController
                                            .pinnedAccounts[index].avatar
                                            .toString(),
                                        customerStatus: accountController
                                            .convertAccountStyleToString(
                                                accountsController
                                                    .pinnedAccounts[index]
                                                    .style),
                                        customerBalance: accountsController
                                            .pinnedAccounts[index].balance
                                            .toString(),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return spacerHeight(height: 25);
                                    },
                                    itemCount: accountsController
                                            .pinnedAccounts.isEmpty
                                        ? 0
                                        : accountsController
                                                    .pinnedAccounts.length <
                                                5
                                            ? accountsController
                                                .pinnedAccounts.length
                                            : 5,
                                  );
                          }),
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
        floatingActionButton: AddButton(
          onPressed: () {
            Get.bottomSheet(CreateBottomSheet());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
