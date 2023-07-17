import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/profile_controller.dart';
import 'package:matjary/BussinessLayer/helpers/date_formatter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_text_form_field.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/section_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';
import 'package:matjary/main.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
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
                const PageTitle(title: 'الملف الشخصي'),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: AssetImage(
                                        'assets/images/user.png',
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -10,
                                      left: 0,
                                      right: -65,
                                      child: CustomIconButton(
                                        onPressed: () {},
                                        circleShape: true,
                                        icon: const Icon(
                                          FontAwesomeIcons.solidPenToSquare,
                                          color: UIColors.primary,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              spacerHeight(height: 22),
                              Text(
                                MyApp.appUser!.name,
                                softWrap: true,
                                style: UITextStyle.normalHeading.copyWith(
                                  color: UIColors.lightNormalText,
                                ),
                              ),
                              spacerHeight(height: 22),
                              Text(
                                'الباقة الاقتصادية',
                                softWrap: true,
                                style: UITextStyle.normalBody.copyWith(
                                  color: UIColors.lightNormalText,
                                ),
                              ),
                              spacerHeight(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'صلاحية الاشتراك:',
                                    softWrap: true,
                                    style: UITextStyle.normalSmall.copyWith(
                                      color: UIColors.lightNormalText,
                                    ),
                                  ),
                                  spacerWidth(width: 6),
                                  Text(
                                    DateFormatter.getFormated(
                                        MyApp.appUser!.expiryDate),
                                    softWrap: true,
                                    style: UITextStyle.normalSmall.copyWith(
                                      color: UIColors.lightNormalText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionTitle(title: 'الاسم'),
                            spacerHeight(),
                            CustomTextFormField(
                              controller: profileController.userNameController,
                              hintText: 'أدخل اسم المستخدم',
                            ),
                            spacerHeight(height: 22),
                            const SectionTitle(title: 'رقم الموبايل'),
                            spacerHeight(),
                            CustomTextFormField(
                              keyboardType: TextInputType.number,
                              controller:
                                  profileController.mobileNumberController,
                              hintText: 'أدخل رقم الموبايل',
                              formatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'))
                              ],
                            ),
                            spacerHeight(height: 22),
                            const SectionTitle(title: 'كلمة المرور'),
                            spacerHeight(),
                            CustomTextFormField(
                              controller: profileController.passwordController,
                              obsecureText: true,
                              hintText: 'أدخل كلمة المرور',
                            ),
                            spacerHeight(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'اتركها فارغة لتجنب التعديل',
                                style: UITextStyle.normalSmall.copyWith(
                                  color: UIColors.normalText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  return AcceptButton(
                    text: 'تعديل بيانات الملف الشخصي',
                    onPressed: () {
                      profileController.updateProfile();
                    },
                    isLoading: profileController.isLoading.value,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
