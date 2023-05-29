import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:matjary/BussinessLayer/Controllers/accounts_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/orders_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/DataAccesslayer/Models/order.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/order_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/orders_filter_bottomsheet.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_group.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_radio_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final ordersController = Get.find<OrdersController>();
  final searchController = Get.put(SearchController());
  final accountsController = Get.find<AccountsController>();

  Widget buildOrdersList(List<Order> orders) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return OrderBox(
          order: orders[index],
        );
      },
      separatorBuilder: (context, index) => spacerHeight(),
      itemCount: orders.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    searchController.list = accountsController.accounts;
    ordersController.currentOrders = ordersController.orders;
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
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(OrdersFilterBottomSheet());
                      },
                      child: Row(
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
                                onTap: () async {
                                  ordersController
                                      .setOrderFilterType(orderFilterType);
                                  await ordersController
                                      .getOrdersByType(orderFilterType);
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
                    searchController.searchText = value;
                    searchController.search();
                  },
                ),
                spacerHeight(height: 22),
                Expanded(
                  child: Obx(() {
                    return ordersController.isLoadingOrders.value
                        ? Center(child: loadingItem(width: 100, isWhite: true))
                        : RefreshIndicator(
                            onRefresh: () async =>
                                await ordersController.getOrdersByType(
                                    ordersController.currentOrderFilterType),
                            child: GetBuilder(
                              init: searchController,
                              builder: (context) {
                                if (searchController.searchText.isEmpty) {
                                  return buildOrdersList(
                                      ordersController.currentOrders);
                                } else {
                                  return Obx(
                                    () {
                                      if (searchController
                                          .searchLoading.value) {
                                        return Center(
                                          child: loadingItem(isWhite: true),
                                        );
                                      } else {
                                        return buildOrdersList(ordersController
                                            .getOrdersForAccounts(
                                                searchController.filteredList));
                                      }
                                    },
                                  );
                                }
                              },
                            ),
                          );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
