import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';

class OrdersFilterBottomSheet extends StatelessWidget {
  OrdersFilterBottomSheet({super.key});

  final ordersController = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * .5,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        borderRadius: raduis32top,
        color: UIColors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async =>
                  await ordersController.getFilteredOrders('last_day'),
              child: Text(
                'فواتير اليوم',
                style: UITextStyle.normalHeading.copyWith(
                  color: UIColors.menuTitle,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async =>
                  await ordersController.getFilteredOrders('last_week'),
              child: Text(
                'فواتير الأسبوع',
                style: UITextStyle.normalHeading.copyWith(
                  color: UIColors.menuTitle,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async =>
                  await ordersController.getFilteredOrders('last_month'),
              child: Text(
                'فواتير آخر شهر',
                style: UITextStyle.normalHeading.copyWith(
                  color: UIColors.menuTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
