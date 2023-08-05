import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/wares_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Order/order_amount_container.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Order/order_info_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_dialog.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/divider.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

// ignore: must_be_immutable
class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final ordersController = Get.find<OrdersController>();
  final accountsController = Get.find<AccountsController>();
  final orderController = Get.put(OrderController());
  final waresController = Get.find<WaresController>();
  Order order = Get.arguments;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: PageTitle(title: 'فاتورة رقم  ${order.id}#')),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.createEditOrderScreen,
                              arguments: order,
                            );
                          },
                          child: const Icon(
                            FontAwesomeIcons.penToSquare,
                            size: 27,
                            color: UIColors.primary,
                          ),
                        ),
                        spacerWidth(width: 22),
                        InkWell(
                          onTap: () {
                            Get.dialog(
                              CustomDialog(
                                title: 'هل تريد حذف الفاتورة؟',
                                acceptButton: Obx(
                                  () => AcceptButton(
                                    text: 'حذف',
                                    onPressed: () async {
                                      await orderController
                                          .deleteOrder(order.id);
                                      Get.until((route) =>
                                          route.settings.name ==
                                          AppRoutes.ordersScreen);
                                    },
                                    isLoading: orderController.loading.value,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.delete,
                            size: 30,
                            color: UIColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                spacerHeight(height: 22),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: UIColors.containerBackground,
                            borderRadius: raduis15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionTitle(
                                title: 'معلومات الفاتورة',
                                titleColor: UIColors.white,
                              ),
                              spacerHeight(height: 30),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OrderInfoItem(
                                        itemTitle: 'النوع',
                                        itemText: ordersController
                                            .counterOrderTypes[order.type]
                                            .toString(),
                                      ),
                                      OrderInfoItem(
                                        itemTitle: 'الطرف المقابل',
                                        itemText: accountsController
                                            .getAccountName(order.customerId),
                                      ),
                                    ],
                                  ),
                                  spacerHeight(),
                                  divider(
                                    thickness: 1,
                                    color: UIColors.white.withOpacity(.2),
                                  ),
                                  spacerHeight(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OrderInfoItem(
                                        itemTitle: 'الصندوق المرتبط',
                                        itemText: accountsController
                                            .getAccountName(order.bankId),
                                      ),
                                      OrderInfoItem(
                                        itemTitle: 'المستودع المرتبط',
                                        itemText: waresController
                                            .getWareName(order.wareId),
                                      ),
                                    ],
                                  ),
                                  spacerHeight(),
                                  divider(
                                    thickness: 1,
                                    color: UIColors.white.withOpacity(.2),
                                  ),
                                  spacerHeight(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OrderInfoItem(
                                        itemTitle: 'حالة الفاتورة',
                                        itemText: ordersController
                                            .counterOrderStatus[order.status]
                                            .toString(),
                                      ),
                                      OrderInfoItem(
                                        itemTitle: 'المسوق',
                                        itemText: order.marketerId != null
                                            ? accountsController.getAccountName(
                                                order.marketerId!)
                                            : 'لا يوجد مسوق',
                                      ),
                                    ],
                                  ),
                                  spacerHeight(),
                                  divider(
                                    thickness: 1,
                                    color: UIColors.white.withOpacity(.2),
                                  ),
                                  spacerHeight(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OrderInfoItem(
                                        itemTitle: 'تاريخ الانشاء',
                                        itemText: order
                                            .getDateString(order.creationDate),
                                      ),
                                      OrderInfoItem(
                                        itemTitle: 'تاريخ آخر تعديل',
                                        itemText: DateUtils.isSameDay(
                                                order.creationDate,
                                                order.updationDate)
                                            ? '---------'
                                            : order.getDateString(
                                                order.updationDate),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        spacerHeight(height: 22),
                        CustomButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.orderDetailsScreen,
                                arguments: order);
                          },
                          backgroundColor: UIColors.primary,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'تفاصيل الفاتورة (البنود)',
                                  style: UITextStyle.normalBody,
                                ),
                                Text(
                                  '>',
                                  style: UITextStyle.boldMeduim,
                                ),
                              ],
                            ),
                          ),
                        ),
                        spacerHeight(height: 22),
                        Column(
                          children: [
                            Row(
                              children: [
                                OrderAmountContainer(
                                  title: 'المبلغ الاجمالي',
                                  amount: order.total.toString(),
                                ),
                                spacerWidth(),
                                OrderAmountContainer(
                                  title: 'المصاريف',
                                  amount: order.expenses.toString(),
                                ),
                              ],
                            ),
                            spacerHeight(),
                            Row(
                              children: [
                                OrderAmountContainer(
                                  title: 'المدفوع',
                                  amount: order.paidUp.toString(),
                                ),
                                spacerWidth(),
                                OrderAmountContainer(
                                  title: 'المتبقي',
                                  amount: order.restOfTheBill.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
