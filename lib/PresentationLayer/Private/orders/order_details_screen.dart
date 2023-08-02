import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/order_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/products_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_details_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/table_titles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});

  final productsController = Get.find<ProductsController>();
  final orderController = Get.find<OrderController>();
  Order order = Get.arguments;

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
                PageTitle(title: 'فاتورة رقم  ${order.id}#'),
                spacerHeight(height: 30),
                const TableTitles(
                  firstColumnTitle: 'المنتج',
                  secondColumnTitle: 'الكمية',
                  thirdColumnTitle: 'الافرادي',
                  fourthColumnTitle: 'الإجمالي',
                ),
                spacerHeight(),
                Expanded(
                  flex: 7,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return TableDetailsItem(
                        firstColumnItem: productsController
                            .getProductName(order.details[index].productId)
                            .toString(),
                        secondColumnItem:
                            order.details[index].quantity.toString(),
                        thirdColumnItem: order.details[index].price.toString(),
                        fourthColumnItem:
                            order.details[index].totalPrice.toString(),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        spacerHeight(height: 10),
                    itemCount: order.details.length,
                  ),
                ),
                spacerHeight(),
                TableTitles(
                  titleTextStyle: UITextStyle.boldMeduim,
                  firstColumnTitle: 'الإجمالي',
                  secondColumnTitle: orderController
                      .getOrderProductsQuantitiesCount(order.details)
                      .toString(),
                  thirdColumnTitle: '',
                  fourthColumnTitle: order.total.toString(),
                ),
                spacerHeight(height: 30),
                AcceptIconButton(
                  text: const Text('حفظ pdf', style: UITextStyle.boldMeduim),
                  icon: const Icon(FontAwesomeIcons.solidFloppyDisk),
                  center: true,
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.orderPrintScreen,
                      arguments: order,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
