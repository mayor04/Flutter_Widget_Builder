import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/view/create_page/sections/section_display.dart';
import 'package:flutter_widget_builder/features/view/create_page/sections/section_styles.dart';
import 'package:flutter_widget_builder/features/view/create_page/sections/section_widget_tree.dart';
import 'package:flutter_widget_builder/features/view/overlay/app_overlay_listener.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBg,
      body: AppOverlayListener(
        child: Column(
          children: [
            Container(
              height: 30,
              width: double.infinity,
              color: AppColors.appDarker,
            ),
            Expanded(
              child: Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}
