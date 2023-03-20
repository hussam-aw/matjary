import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matjary/Constants/ui_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        color: UIColors.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: Icon(
                  size: 28,
                  FontAwesomeIcons.houseChimney,
                  color: UIColors.white,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  size: 28,
                  FontAwesomeIcons.fileInvoice,
                  color: UIColors.white,
                ),
                onPressed: () {},
              ),
            ),
            const Expanded(child: Text('')),
            Expanded(
              child: IconButton(
                icon: Icon(
                  size: 28,
                  FontAwesomeIcons.user,
                  color: UIColors.white,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  size: 28,
                  Icons.analytics,
                  color: UIColors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
