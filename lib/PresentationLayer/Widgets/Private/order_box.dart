import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class OrderBox extends StatelessWidget {
  OrderBox({
    super.key,
    required this.order,
  });

  final Order order;
  final accountsController = Get.find<AccountsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: UIColors.containerBackground,
        borderRadius: raduis15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 67,
              decoration: const BoxDecoration(
                color: UIColors.primary,
                borderRadius: raduis10,
              ),
              child: Center(
                child: Text(
                  '#${order.id}',
                  overflow: TextOverflow.ellipsis,
                  style: UITextStyle.boldHeadingRedHat,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الزبون ${accountsController.getAccountName(order.customerId)}',
                    style: UITextStyle.boldBody,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spacerHeight(height: 12),
                  Text(
                    'إجمالي الفاتورة :   ${order.total}',
                    style: UITextStyle.normalSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spacerHeight(height: 8),
                  Text(
                    order.getDateString(order.creationDate),
                    style: UITextStyle.normalSmall.copyWith(
                      color: UIColors.titleNoteText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            width: 90,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
                borderRadius: raduis15,
                color: UIColors.iconButtonGroupBackground),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.orderScreen,
                      arguments: order,
                    );
                  },
                  child: const Icon(
                    FontAwesomeIcons.eye,
                    color: UIColors.primary,
                    size: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.createEditOrderScreen,
                      arguments: order,
                    );
                  },
                  child: const Icon(
                    FontAwesomeIcons.penToSquare,
                    color: UIColors.primary,
                    size: 20,
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
