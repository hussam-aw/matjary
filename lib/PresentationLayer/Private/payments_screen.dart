import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/payment_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/payments_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/payment.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/payment_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/add_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class PaymentsScreen extends StatelessWidget {
  PaymentsScreen({super.key});

  final paymentsController = Get.find<PaymentsController>();

  Widget buildPaymentsList(List<Payment> payments) {
    return payments.isEmpty
        ? Center(
            child: Text(
              'لا يوجد دفعات',
              style: UITextStyle.normalBody.copyWith(
                color: UIColors.normalText,
              ),
            ),
          )
        : ListView.separated(
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
                Expanded(
                  child: Obx(() {
                    return paymentsController.isLoading.value
                        ? Center(child: loadingItem(width: 100, isWhite: true))
                        : RefreshIndicator(
                            onRefresh: () async =>
                                await paymentsController.getPayments(),
                            child:
                                buildPaymentsList(paymentsController.payments),
                          );
                  }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AddButton(
          backgroundColor: UIColors.primary,
          iconColor: UIColors.white,
          onPressed: () {
            Get.toNamed(AppRoutes.createEditPaymentScreen);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
