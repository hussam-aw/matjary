import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/search_controller.dart';
import 'package:matjary/BussinessLayer/Controllers/users_controller.dart';
import 'package:matjary/Constants/get_routes.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/add_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/loading_item.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/search_text_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';

// ignore: must_be_immutable
class ChooseUserScreen extends StatelessWidget {
  ChooseUserScreen({super.key});

  final UsersController usersController = Get.find<UsersController>();
  final ListSearchController searchController = Get.put(ListSearchController());

  Widget buildUserList(userList) {
    return userList.isEmpty
        ? Center(
            child: Text(
              'لا يوجد مستخدمين',
              style: UITextStyle.normalBody.copyWith(
                color: UIColors.normalText,
              ),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return NormalBox(
                title: userList[index].name,
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) {
              return spacerHeight();
            },
            itemCount: userList.length,
          );
  }

  @override
  Widget build(BuildContext context) {
    searchController.setSearchList(usersController.users);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                const PageTitle(title: 'المستخدمين'),
                spacerHeight(),
                SearchTextField(
                  hintText: 'قم بالبحث عن اسم المستخدم أو اختر من القائمة',
                  onChanged: (value) {
                    searchController.search(value);
                  },
                ),
                spacerHeight(height: 20),
                Expanded(
                  child: Obx(
                    () => usersController.isLoadingUsers.value
                        ? Center(
                            child: loadingItem(width: 100, isWhite: true),
                          )
                        : RefreshIndicator(
                            onRefresh: () async =>
                                await usersController.getUsers(),
                            child: GetBuilder(
                              init: searchController,
                              builder: (context) {
                                return searchController.searchText.isEmpty
                                    ? buildUserList(usersController.users)
                                    : Obx(
                                        () {
                                          return searchController
                                                  .searchLoading.value
                                              ? Center(
                                                  child: loadingItem(
                                                      width: 100,
                                                      isWhite: true),
                                                )
                                              : buildUserList(searchController
                                                  .filteredList);
                                        },
                                      );
                              },
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AddButton(
          backgroundColor: UIColors.primary,
          iconColor: UIColors.white,
          onPressed: () {
            Get.toNamed(AppRoutes.createEditUserScreen);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
