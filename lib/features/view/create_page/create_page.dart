import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/features/view/create_page/sections/section_display.dart';
import 'package:flutter_widget_builder/features/view/create_page/sections/section_styles.dart';
import 'package:flutter_widget_builder/features/view/create_page/sections/section_widget_tree.dart';
import 'package:flutter_widget_builder/features/view/overlay/app_overlay.dart';
import 'package:flutter_widget_builder/features/widget_creator/bloc/notifier_bloc.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBg,
      body: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            color: AppColors.appDarker,
            child: Row(
              children: [
                const SizedBox(
                  width: 70,
                  child: Icon(
                    Icons.home,
                    color: AppColors.inputBorder,
                    size: 21,
                  ),
                ),
                const Box.vertical(20),
                Container(
                  color: AppColors.appGrey,
                  width: 150,
                  alignment: Alignment.center,
                  child: Text(
                    'Twitter widget',
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(23, 15, 23, 15),
              child: Row(
                children: [
                  const SectionWidgetTree(),
                  const Box.horizontal(15),
                  const SectionStyles(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<NotifierBloc>().select(0);
                        AppOverlay.removeAll(context);
                      },
                      child: const SectionDisplay(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
