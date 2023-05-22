import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/order_screen_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/PresentationLayer/Private/Order/delivery_details.dart';
import 'package:matjary/PresentationLayer/Private/Order/order_basic_information.dart';
import 'package:matjary/PresentationLayer/Private/Order/order_details.dart';
import 'package:matjary/PresentationLayer/Private/Order/saving_order.dart';
import 'package:matjary/PresentationLayer/Private/Order/success_saving_order.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/stepper_component.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class CreateEditOrderScreen extends StatelessWidget {
  CreateEditOrderScreen({super.key});

  final orderController = Get.put(OrderController());
  final orderScreenController = Get.put(OrderScreenController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          orderScreenController.goToPreviousPage();
          return false;
        },
        child: Scaffold(
          backgroundColor: UIColors.mainBackground,
          appBar: customAppBar(showingAppIcon: false),
          drawer: CustomDrawer(),
          body: Container(
            padding: const EdgeInsets.only(right: 25, bottom: 15, left: 25),
            child: Column(
              children: [
                Obx(() {
                  return orderScreenController.currentIndex.value == 0
                      ? const PageTitle(title: 'فاتورة جديدة')
                      : spacerHeight(height: 40);
                }),
                spacerHeight(),
                Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Obx(
                    () => Row(
                      children: [
                        StepperComponent(
                          title: 'المعلومات الرئيسية',
                          currentIndex:
                              orderScreenController.currentIndex.value,
                          index: 0,
                        ),
                        StepperComponent(
                          title: 'تفاصيل الفاتورة',
                          currentIndex:
                              orderScreenController.currentIndex.value,
                          index: 1,
                        ),
                        StepperComponent(
                          title: 'تفاصيل التسليم',
                          currentIndex:
                              orderScreenController.currentIndex.value,
                          index: 2,
                        ),
                        StepperComponent(
                          title: 'حفظ الفاتورة',
                          currentIndex:
                              orderScreenController.currentIndex.value,
                          index: 3,
                          isLast: true,
                          icon: Icon(
                            Icons.check,
                            size: 28,
                            color: UIColors.mainIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spacerHeight(),
                Expanded(
                    child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: orderScreenController.pageController,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return orderScreenController.getSelectedPage(
                        orderScreenController.currentIndex.value);
                  },
                )),
                Obx(() {
                  return orderScreenController.currentIndex <= 3
                      ? orderScreenController.currentIndex.value == 3
                          ? AcceptButton(
                              text: 'حفظ',
                              isLoading: orderController.loading.value,
                              onPressed: () async {
                                await orderController.createOrder();
                                if (orderController.orderSaving == true) {
                                  orderScreenController.goToNextPage();
                                }
                              },
                            )
                          : AcceptButton(
                              text: 'التالي',
                              onPressed: () {
                                orderScreenController.goToNextPage();
                              },
                            )
                      : Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
