import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_screen_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class PaymentBox extends StatelessWidget {
  PaymentBox({super.key, required this.payment});

  final paymentScreenController = Get.put(PaymentScreenController());
  final accountsController = Get.find<AccountsController>();
  final Payment payment;

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
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Icon(
                        paymentScreenController
                                    .counterPaymentTypes[payment.type] ==
                                'مقبوضات'
                            ? FontAwesomeIcons.solidCircleDown
                            : FontAwesomeIcons.solidCircleUp,
                        size: 40,
                        color: UIColors.white,
                      ),
                    ),
                    spacerHeight(),
                    Expanded(
                      child: Text(
                        paymentScreenController
                                    .counterPaymentTypes[payment.type] ==
                                'مقبوضات'
                            ? 'مقبوضات'
                            : 'مدفوعات',
                        overflow: TextOverflow.ellipsis,
                        style: UITextStyle.normalMeduim,
                      ),
                    ),
                  ],
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
                    payment.amount.toString(),
                    style: UITextStyle.boldBody,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spacerHeight(height: 12),
                  Text(
                    'الطرف المقابل: ${payment.counterParty.name}',
                    style: UITextStyle.normalSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spacerHeight(height: 8),
                  Text(
                    payment.getDateString(payment.date),
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
                    // Get.toNamed(
                    //   AppRoutes.orderScreen,
                    //   arguments: order,
                    // );
                  },
                  child: const Icon(
                    FontAwesomeIcons.penToSquare,
                    color: UIColors.primary,
                    size: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.toNamed(
                    //   AppRoutes.createEditOrderScreen,
                    //   arguments: order,
                    // );
                  },
                  child: const Icon(
                    Icons.delete,
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
