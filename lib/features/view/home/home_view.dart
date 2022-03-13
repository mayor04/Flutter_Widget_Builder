import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/view/home/sections/section_display.dart';
import 'package:flutter_widget_builder/features/view/home/sections/section_styles.dart';
import 'package:flutter_widget_builder/features/view/home/sections/section_widget_tree.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBg,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(23, 15, 23, 15),
        child: Row(
          children: const [
            SectionWidgetTree(),
            Box.horizontal(15),
            SectionStyles(),
            Expanded(child: SectionDisplay()),
          ],
        ),
      ),
    );
  }
}