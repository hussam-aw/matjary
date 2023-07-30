// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class OrderProductBox extends StatelessWidget {
  OrderProductBox({
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    this.backgroundColor,
    this.screenMode,
  });

  final String productName;
  final int? quantity;
  final num? price;
  final num totalPrice;
  final Color? backgroundColor;
  final String? screenMode;

  @override
  Widget build(BuildContext context) {
    Color textColor = screenMode == null ? UIColors.white : UIColors.printText;
    return Container(
      //height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
      decoration: BoxDecoration(
        color: screenMode == null ? backgroundColor : UIColors.white,
        borderRadius: raduis15,
        border: screenMode != null
            ? Border.all(color: UIColors.containerBorder)
            : null,
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
                  productName,
                  softWrap: true,
                  //overflow: TextOverflow.ellipsis,
                  style: UITextStyle.normalBody.copyWith(
                    color: textColor,
                  ),
                ),
                spacerHeight(),
                Row(
                  children: [
                    Text(
                      'الكمية:',
                      softWrap: true,
                      style: UITextStyle.small.copyWith(
                        color: textColor,
                      ),
                    ),
                    spacerWidth(),
                    Text(
                      quantity.toString(),
                      softWrap: true,
                      style: UITextStyle.normalSmall.copyWith(
                        color: textColor,
                      ),
                    ),
                    spacerWidth(width: 10),
                    Text(
                      'الافرادي:',
                      softWrap: true,
                      style: UITextStyle.small.copyWith(
                        color: textColor,
                      ),
                    ),
                    spacerWidth(),
                    Text(
                      price!.toStringAsFixed(2),
                      softWrap: true,
                      style: UITextStyle.normalSmall.copyWith(
                        color: textColor,
                      ),
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
                Text(
                  'الإجمالي',
                  softWrap: true,
                  //overflow: TextOverflow.ellipsis,
                  style: UITextStyle.normalBody.copyWith(
                    color: textColor,
                  ),
                ),
                spacerHeight(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    totalPrice.toStringAsFixed(1),
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                    style: UITextStyle.normalMeduim.copyWith(
                      color: textColor,
                    ),
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
  }
}
