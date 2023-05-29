import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/product.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/amount_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/update_order_product_bottomsheet.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
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
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
      decoration: const BoxDecoration(
        color: UIColors.containerBackground,
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
                Expanded(
                  flex: 2,
                  child: Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: UITextStyle.normalBody,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'الكمية:',
                        style: UITextStyle.small,
                      ),
                      spacerWidth(width: 4),
                      AmountBox(
                        amount: quantity.toString(),
                      ),
                      spacerWidth(width: 6),
                      const Text(
                        'الافرادي:',
                        style: UITextStyle.small,
                      ),
                      spacerWidth(width: 4),
                      AmountBox(
                        amount: price!.toStringAsFixed(2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                totalPrice.toStringAsFixed(1),
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.normalMeduim,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.bottomSheet(UpdateOrderProductBottomSheet(
                      productId: product.id,
                      currentQuantity: orderScreenController
                          .selectedProductsQuantities[product.id],
                      currentPrice: orderScreenController
                          .selectedProductPrices[product.id],
                    ));
                  },
                  child: const Icon(
                    FontAwesomeIcons.penToSquare,
                    size: 17,
                    color: UIColors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    orderScreenController.deleteSelectedProduct(product.id);
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 20,
                    color: UIColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
