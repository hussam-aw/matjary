import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/Constants/ui_text_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/normal_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Private/selection_order_product_box.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/accept_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_app_bar.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_drawer.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/page_title.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerHeight.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class SelectProductsScreen extends StatelessWidget {
  const SelectProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: UIColors.mainBackground,
        appBar: customAppBar(showingAppIcon: false),
        drawer: CustomDrawer(),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            children: [
              const PageTitle(title: 'اختيار منتجات'),
              spacerHeight(),
              TextFormField(
                textAlign: TextAlign.center,
                style: UITextStyle.normalMeduim,
                decoration: normalTextFieldStyle.copyWith(
                  hintText: 'اكتب اسم المنتج أو جزء منه للفلترة',
                ),
                onChanged: (value) {},
              ),
              spacerHeight(height: 25),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.circleInfo,
                    size: 37,
                    color: UIColors.white,
                  ),
                  spacerWidth(),
                  SizedBox(
                    width: 210,
                    child: Text(
                      'قم بزيادة العدد لاختيار المنتج بأزرار الزيادة والنقصان أو قم بإدخاله بالضغط على 123',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: UITextStyle.normalSmall.copyWith(
                        height: 2,
                      ),
                    ),
                  ),
                ],
              ),
              spacerHeight(height: 22),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return SelectionOrderProductBox();
                  },
                  separatorBuilder: (context, index) => spacerHeight(),
                  itemCount: 30,
                ),
              ),
              spacerHeight(),
              AcceptButton(
                text: 'اختيار',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
