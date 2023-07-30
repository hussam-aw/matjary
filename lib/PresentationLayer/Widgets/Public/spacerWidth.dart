// ignore_for_file: file_names, camel_case_types, must_be_immutable
import 'package:flutter/material.dart';

class spacerWidth extends StatelessWidget {
  spacerWidth({super.key, this.width = 14.0});

  double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
