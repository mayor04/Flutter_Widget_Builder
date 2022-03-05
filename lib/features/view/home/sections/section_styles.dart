import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';

class SectionStyles extends StatelessWidget {
  const SectionStyles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: AppColors.appDark,
    );
  }
}
