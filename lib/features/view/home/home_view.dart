import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/features/view/home/sections/section_display.dart';
import 'package:flutter_widget_builder/features/view/home/sections/section_styles.dart';
import 'package:flutter_widget_builder/features/view/home/sections/section_widget_tree.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: const [
          SectionWidgetTree(),
          Expanded(child: SectionDisplay()),
          SectionStyles(),
        ],
      ),
    );
  }
}
