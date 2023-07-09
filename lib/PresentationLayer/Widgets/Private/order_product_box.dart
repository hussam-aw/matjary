import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class OrderProductBox extends StatelessWidget {
  OrderProductBox({
    super.key,
    required this.product,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  final Product product;
  final int? quantity;
  final num? price;
  final num totalPrice;
  final orderScreenController = Get.find<OrderScreenController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        orderScreenController.openUpdateProductBottomSheet(product);
      },
      child: GetBuilder(
          init: orderScreenController,
          builder: (context) {
            return Container(
              //height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              decoration: BoxDecoration(
                color: orderScreenController
                        .checkIfProductSelectedForUpdate(product)
                    ? UIColors.primary
                    : UIColors.containerBackground,
                borderRadius: raduis15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          softWrap: true,
                          //overflow: TextOverflow.ellipsis,
                          style: UITextStyle.normalBody,
                        ),
                        spacerHeight(),
                        Row(
                          children: [
                            const Text(
                              'الكمية:',
                              softWrap: true,
                              style: UITextStyle.small,
                            ),
                            spacerWidth(),
                            Text(
                              quantity.toString(),
                              softWrap: true,
                              style: UITextStyle.normalSmall,
                            ),
                            spacerWidth(width: 10),
                            const Text(
                              'الافرادي:',
                              softWrap: true,
                              style: UITextStyle.small,
                            ),
                            spacerWidth(),
                            Text(
                              price!.toStringAsFixed(2),
                              softWrap: true,
                              style: UITextStyle.normalSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  spacerWidth(),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Text(
                          'الإجمالي',
                          softWrap: true,
                          //overflow: TextOverflow.ellipsis,
                          style: UITextStyle.normalBody,
                        ),
                        spacerHeight(),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            totalPrice.toStringAsFixed(1),
                            softWrap: true,
                            //overflow: TextOverflow.ellipsis,
                            style: UITextStyle.normalMeduim,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.end,
                  //     children: [
                  //       InkWell(
                  //         onTap: () {
                  //           Get.bottomSheet(UpdateOrderProductBottomSheet(
                  //             productId: product.id,
                  //             currentQuantity: orderScreenController
                  //                 .selectedProductsQuantities[product.id],
                  //             currentPrice: orderScreenController
                  //                 .selectedProductPrices[product.id],
                  //           ));
                  //         },
                  //         child: const Icon(
                  //           FontAwesomeIcons.penToSquare,
                  //           size: 17,
                  //           color: UIColors.white,
                  //         ),
                  //       ),
                  //       spacerHeight(),
                  //       InkWell(
                  //         onTap: () {
                  //           orderScreenController.deleteSelectedProduct(product.id);
                  //         },
                  //         child: const Icon(
                  //           Icons.delete,
                  //           size: 20,
                  //           color: UIColors.white,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          }),
    );
  }
}
