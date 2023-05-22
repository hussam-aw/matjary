import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/order_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final ordersController = Get.find<OrdersController>();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const PageTitle(title: 'الفواتير'),
                    Row(
                      children: [
                        const Icon(
                          Icons.filter_alt_outlined,
                          size: 30,
                          color: UIColors.titleNoteIcon,
                        ),
                        Text(
                          'فلترة',
                          style: UITextStyle.normalBody
                              .copyWith(color: UIColors.titleNoteText),
                        ),
                      ],
                    ),
                  ],
                ),
                spacerHeight(height: 22),
                Obx(
                  () {
                    return CustomRadioGroup(
                      items: ordersController.orderFilterTypes
                          .map((orderFilterType) => RadioButtonItem(
                                text: orderFilterType,
                                selectionColor: UIColors.primary,
                                selectedTextColor: UIColors.white,
                                isSelected: ordersController
                                    .orderFilterTypesSelection
                                    .value[orderFilterType]!,
                                onTap: () {
                                  ordersController
                                      .setOrderFilterType(orderFilterType);
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
                spacerHeight(height: 22),
                SearchTextField(
                  hintText: 'قم بالبحث عن اسم الحساب أو اختر من القائمة',
                  onChanged: (value) {
                    // searchController.searchText = value;
                    // searchController.search();
                  },
                ),
                spacerHeight(height: 22),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return OrderBox();
                    },
                    separatorBuilder: (context, index) => spacerHeight(),
                    itemCount: 10,
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
