import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Order/order_product_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key});

  final orderScreenController = Get.find<OrderScreenController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'تفاصيل الفاتورة'),
            spacerHeight(),
            SizedBox(
              width: 120,
              child: AcceptButton(
                onPressed: () {
                  orderScreenController.selectedProducts.clear();
                  Get.toNamed(AppRoutes.selectProducts);
                },
                backgroundColor: UIColors.primary,
                text: 'اختيار منتجات',
              ),
            ),
            spacerHeight(),
            Expanded(
              child: Obx(() {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return Obx(() {
                      var product =
                          orderScreenController.selectedProducts[index];
                      var price = orderScreenController
                          .selectedProductPrices[product.id];
                      var quantity = orderScreenController
                          .selectedProductsQuantities[product.id];
                      return GetBuilder(
                          init: orderScreenController,
                          builder: (context) {
                            return InkWell(
                              onLongPress: () {
                                orderScreenController
                                    .openUpdateProductBottomSheet(product);
                              },
                              child: OrderProductBox(
                                productName: product.name,
                                quantity: quantity,
                                price: price,
                                totalPrice: orderScreenController
                                    .calculateTotalProdcutPrice(
                                        price, quantity),
                                backgroundColor: orderScreenController
                                        .checkIfProductSelectedForUpdate(
                                            product)
                                    ? UIColors.primary
                                    : UIColors.containerBackground,
                              ),
                            );
                          });
                    });
                  },
                  separatorBuilder: (context, index) => spacerHeight(),
                  itemCount: orderScreenController.selectedProducts.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
