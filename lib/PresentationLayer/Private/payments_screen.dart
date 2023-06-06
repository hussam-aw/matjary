import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/payment_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  Widget buildPaymentsList(List<Payment> payments) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return PaymentBox(
          payment: payments[index],
        );
      },
      separatorBuilder: (context, index) => spacerHeight(),
      itemCount: payments.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'الدفعات'),
                spacerHeight(height: 22),
                // Expanded(
                //   child: Obx(() {
                //     return ordersController.isLoadingOrders.value
                //         ? Center(child: loadingItem(width: 100, isWhite: true))
                //         : RefreshIndicator(
                //             onRefresh: () async =>
                //                 await ordersController.getOrdersByType(
                //                     ordersController.currentOrderFilterType),
                //             child: buildPaymentsList(payments),
                //           );
                //   }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
