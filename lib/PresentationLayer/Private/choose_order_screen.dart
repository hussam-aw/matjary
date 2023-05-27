import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/account_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/ware_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/custom_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class ChooseOrderScreen extends StatelessWidget {
  ChooseOrderScreen({super.key});

  final OrdersController ordersController = Get.find<OrdersController>();

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
                const PageTitle(title: 'إختيار طلب'),
                spacerHeight(),
                SearchTextField(
                  hintText: 'قم بالبحث عن الطلب أو اختر من القائمة',
                  onChanged: (value) {},
                ),
                spacerHeight(height: 20),
                Expanded(
                  child: GetBuilder(
                    init: ordersController,
                    builder: (context) => ordersController.orders.isEmpty
                        ? Center(
                            child: loadingItem(width: 100, isWhite: true),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return CustomBox(
                                title: ordersController.orders[index].id
                                    .toString(),
                                editOnPressed: () {
                                  //Navigate to edit order screen
                                },
                                deleteDialogTitle:
                                    'هل تريد بالتأكيد حذف الطلب؟',
                                deleteOnPressed: () {
                                  //Delete from order controller
                                  Get.back();
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return spacerHeight();
                            },
                            itemCount: ordersController.orders.length,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
