import 'package:flutter/material.dart';
import 'package:matjary/Constants/ui_colors.dart';
import 'package:matjary/Constants/ui_styles.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/custom_icon_button.dart';
import 'package:matjary/PresentationLayer/Widgets/Public/spacerWidth.dart';

class OrderProductBox extends StatelessWidget {
  const OrderProductBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: UIColors.containerBackground,
        borderRadius: raduis15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('باوربانك ريماكس RM-79'),
              Row(
                children: [
                  Text('الكمية:'),
                  Container(),
                  spacerWidth(),
                  Text('الافرادي:'),
                  Container(),
                ],
              ),
            ],
          ),
          Text('25000'),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Icon(
                  Icons.edit,
                  size: 25,
                ),
                onTap: () {},
              ),
              InkWell(
                child: Icon(
                  Icons.delete,
                  size: 25,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
