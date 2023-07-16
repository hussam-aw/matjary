import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
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
                  child: Text(
                    "مرحباً بك : ${MyApp.appUser!.name}",
                    softWrap: true,
                    style: UITextStyle.boldBody,
                    textAlign: TextAlign.right,
                  ),
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
                      spacerHeight(
                        height: 5,
                      ),
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
                                var account = await accountsController
                                    .selectAccount(accountsController.accounts);
                                Get.toNamed(
                                  AppRoutes.accountStatementTypeScreen,
                                  arguments: account,
                                );
                              },
                              icon: 'assets/icons/D_ORDERS_icon.png',
                              title: 'كشف حساب',
                              textColor: Colors.white54,
                            ),
                            CreateMenuItem(
                              onTap: () {
                                Get.toNamed(AppRoutes.createEditPaymentScreen);
                              },
                              icon: 'assets/icons/DExpense.png',
                              title: 'دفعة نقدية',
                              textColor: Colors.white54,
                            ),
                            CreateMenuItem(
                              onTap: () {
                                Get.toNamed(AppRoutes.createStatementScreen);
                              },
                              icon: 'assets/icons/D_calc_icon.png',
                              title: 'قيد محاسبي',
                              textColor: Colors.white54,
                            ),
                            CreateMenuItem(
                              onTap: () {
                                Get.toNamed(AppRoutes.productReportScreen);
                              },
                              icon: 'assets/icons/D_ware_icon.png',
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
                  child: Padding(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.moneyCheckDollar,
                                        color: UIColors.primary,
                                        size: 50,
                                      ),
                                      spacerWidth(),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'السيولة النقدية',
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: UITextStyle.normalSmall,
                                            ),
                                            spacerHeight(height: 10),
                                            Obx(
                                              () => accountsController
                                                      .isLoadingAccounts.value
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OrderIconButton(
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoutes.createEditPaymentScreen,
                                          arguments: 'مقبوضات',
                                        );
                                      },
                                      title: 'استلام',
                                      icon: FontAwesomeIcons.solidCircleDown,
                                    ),
                                    spacerWidth(width: 10),
                                    OrderIconButton(
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoutes.createEditPaymentScreen,
                                          arguments: 'مدفوعات',
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
                              invoiceType: 'فواتير المشتريات',
                              invoiceCountWidget: Obx(() {
                                return ordersController.isLoadingOrders.value
                                    ? const OrderCountShimmer()
                                    : Text(
                                        ordersController.purchasesOrders.length
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
                              invoiceType: 'فواتير المبيعات',
                              invoiceCountWidget: Obx(() {
                                return ordersController.isLoadingOrders.value
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
                ),
                SizedBox(
                  height: 400,
                  child: Container(
                    width: Get.width,
                    padding:
                        const EdgeInsets.only(top: 30, left: 35, right: 35),
                    decoration: const BoxDecoration(
                      color: UIColors.containerBackground,
                      borderRadius: raduis32top,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'حسابات العملاء',
                          softWrap: true,
                          style: UITextStyle.boldBody,
                        ),
                        spacerHeight(height: 10),
                        Expanded(
                          child: Obx(() {
                            return accountsController.isLoadingAccounts.value
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
                                                .customersAccounts[index],
                                          );
                                        },
                                        customerName: accountsController
                                            .customersAccounts[index].name,
                                        customerImage: 'assets/images/user.png',
                                        customerStatus: accountController
                                            .convertAccountStyleToString(
                                                accountsController
                                                    .customersAccounts[index]
                                                    .style),
                                        customerBalance: accountsController
                                            .customersAccounts[index].balance
                                            .toString(),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return spacerHeight(height: 25);
                                    },
                                    itemCount: accountsController
                                            .customersAccounts.isEmpty
                                        ? 0
                                        : accountsController
                                                    .customersAccounts.length <
                                                5
                                            ? accountsController
                                                .customersAccounts.length
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
