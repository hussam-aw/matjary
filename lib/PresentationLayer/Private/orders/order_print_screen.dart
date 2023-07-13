import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Order/order_print_details_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Order/order_product_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class OrderPrintScreen extends StatelessWidget {
  OrderPrintScreen({super.key});

  final orderController = Get.put(OrderController());
  final productsController = Get.find<ProductsController>();

  Order order = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                spacerHeight(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PageTitle(
                        title: 'فاتورة رقم  ${order.id}#',
                        titleColor: UIColors.printText,
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         Get.toNamed(
                    //           AppRoutes.createEditOrderScreen,
                    //           arguments: order,
                    //         );
                    //       },
                    //       child: const Icon(
                    //         FontAwesomeIcons.penToSquare,
                    //         size: 27,
                    //         color: UIColors.primary,
                    //       ),
                    //     ),
                    //     spacerWidth(width: 22),
                    //     InkWell(
                    //       onTap: () {
                    //         Get.dialog(
                    //           CustomDialog(
                    //             title: 'هل تريد حذف الفاتورة؟',
                    //             buttonText: 'حذف',
                    //             confirmOnPressed: () async {
                    //               await orderController.deleteOrder(order.id);
                    //               Get.until((route) =>
                    //                   route.settings.name ==
                    //                   AppRoutes.ordersScreen);
                    //             },
                    //           ),
                    //         );
                    //       },
                    //       child: const Icon(
                    //         Icons.delete,
                    //         size: 30,
                    //         color: UIColors.primary,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                spacerHeight(height: 22),
                OrderPrintDetailsBox(order: order),
                spacerHeight(height: 22),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return OrderProductBox(
                        productName: productsController
                            .getProductName(order.details[index].productId),
                        price: order.details[index].price,
                        quantity: order.details[index].quantity,
                        totalPrice: order.details[index].totalPrice,
                        screenMode: 'print',
                      );
                    },
                    separatorBuilder: (context, index) => spacerHeight(),
                    itemCount: order.details.length,
                  ),
                ),
                spacerHeight(),
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
