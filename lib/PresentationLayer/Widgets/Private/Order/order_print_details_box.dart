import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class OrderPrintDetailsBox extends StatelessWidget {
  OrderPrintDetailsBox({super.key, required this.order});

  final accountsController = Get.find<AccountsController>();

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: raduis15,
        border: Border.all(color: UIColors.containerBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات الفاتورة',
            softWrap: true,
            style: UITextStyle.boldBody.copyWith(
              color: UIColors.printText,
            ),
          ),
          spacerHeight(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الطرف المقابل:',
                softWrap: true,
                style: UITextStyle.normalBody.copyWith(
                  color: UIColors.printText,
                ),
              ),
              spacerWidth(),
              Expanded(
                child: Text(
                  accountsController.getAccountName(order.customerId),
                  softWrap: true,
                  style: UITextStyle.boldBody.copyWith(
                    color: UIColors.printText,
                  ),
                ),
              ),
            ],
          ),
          spacerHeight(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تاريخ الانشاء:',
                softWrap: true,
                style: UITextStyle.normalBody.copyWith(
                  color: UIColors.printText,
                ),
              ),
              spacerWidth(),
              Expanded(
                child: Text(
                  DateFormatter.getDateString(order.creationDate),
                  softWrap: true,
                  style: UITextStyle.boldBody.copyWith(
                    color: UIColors.printText,
                  ),
                ),
              ),
            ],
          ),
          spacerHeight(height: 32),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'إجمالي الفاتورة',
                      softWrap: true,
                      style: UITextStyle.normalBody.copyWith(
                        color: UIColors.printText,
                      ),
                    ),
                    spacerHeight(),
                    Text(
                      order.total.toString(),
                      softWrap: true,
                      style: UITextStyle.boldMeduim.copyWith(
                        color: UIColors.printText,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'المبلغ المدفوع',
                      softWrap: true,
                      style: UITextStyle.normalBody.copyWith(
                        color: UIColors.printText,
                      ),
                    ),
                    spacerHeight(),
                    Text(
                      order.paidUp.toString(),
                      softWrap: true,
                      style: UITextStyle.boldMeduim.copyWith(
                        color: UIColors.printText,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'المبلغ المتبقي',
                      softWrap: true,
                      style: UITextStyle.normalBody.copyWith(
                        color: UIColors.printText,
                      ),
                    ),
                    spacerHeight(),
                    Text(
                      order.restOfTheBill.toString(),
                      softWrap: true,
                      style: UITextStyle.boldMeduim.copyWith(
                        color: UIColors.printText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
