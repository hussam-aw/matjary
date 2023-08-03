import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_screen_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/Statements/statement_type_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class PaymentBox extends StatelessWidget {
  PaymentBox({super.key, required this.payment});

  final paymentScreenController = Get.put(PaymentScreenController());
  final accountsController = Get.find<AccountsController>();
  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: UIColors.containerBackground,
        borderRadius: raduis15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatementTypeBox(
            statementTypeIcon:
                paymentScreenController.getPaymenetTypeIcon(payment.type),
            statementType: paymentScreenController.getPaymentType(payment.type),
            onTap: () {
              Get.toNamed(AppRoutes.createEditPaymentScreen,
                  arguments: {'payment': payment});
            },
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.amount.toString(),
                    style: UITextStyle.boldBody,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                  ),
                  spacerHeight(height: 12),
                  Text(
                    'الطرف المقابل: ${payment.counterParty.name}',
                    style: UITextStyle.normalSmall,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                  ),
                  spacerHeight(height: 12),
                  Text(
                    payment.statement.isNotEmpty
                        ? payment.statement
                        : "لا يوجد بيان",
                    style: UITextStyle.normalSmall,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                  ),
                  spacerHeight(height: 8),
                  Text(
                    DateFormatter.getDateString(payment.date),
                    softWrap: true,
                    style: UITextStyle.normalSmall.copyWith(
                      color: UIColors.titleNoteText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   height: 40,
          //   width: 90,
          //   padding: const EdgeInsets.symmetric(horizontal: 14),
          //   decoration: const BoxDecoration(
          //       borderRadius: raduis15,
          //       color: UIColors.iconButtonGroupBackground),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       InkWell(
          //         onTap: () {
          //           // Get.toNamed(
          //           //   AppRoutes.orderScreen,
          //           //   arguments: order,
          //           // );
          //         },
          //         child: const Icon(
          //           FontAwesomeIcons.penToSquare,
          //           color: UIColors.primary,
          //           size: 22,
          //         ),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           // Get.toNamed(
          //           //   AppRoutes.createEditOrderScreen,
          //           //   arguments: order,
          //           // );
          //         },
          //         child: const Icon(
          //           Icons.delete,
          //           color: UIColors.primary,
          //           size: 27,
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
