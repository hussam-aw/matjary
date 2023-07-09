import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/order_product_box.dart';
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
                      var price = orderScreenController.selectedProductPrices[
                          orderScreenController.selectedProducts[index].id];
                      var quantity =
                          orderScreenController.selectedProductsQuantities[
                              orderScreenController.selectedProducts[index].id];
                      return OrderProductBox(
                        product: orderScreenController.selectedProducts[index],
                        quantity: quantity,
                        price: price,
                        totalPrice:
                            orderScreenController.calculateTotalProdcutPrice(
                          price,
                          quantity,
                        ),
                      );
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
