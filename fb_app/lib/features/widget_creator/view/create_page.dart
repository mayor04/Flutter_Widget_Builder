import 'package:fb_app/features/widget_creator/bloc/notifier_bloc.dart';
import 'package:fb_app/features/widget_creator/view/sections/section_display.dart';
import 'package:fb_app/features/widget_creator/view/sections/section_styles.dart';
import 'package:fb_app/features/widget_creator/view/sections/section_widget_tree.dart';
import 'package:fb_app/widget/box_spacing.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sections/code_section.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key, required this.fileId}) : super(key: key);

  final String? fileId;

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool showCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBg,
      body: Column(
        children: [
          // * @TOP BAR
          // Container(
          //   height: 40,
          //   width: double.infinity,
          //   color: AppColors.appDarker,
          //   child: Row(
          //     children: [
          //       const SizedBox(
          //         width: 70,
          //         child: Icon(
          //           Icons.home,
          //           color: AppColors.inputBorder,
          //           size: 21,
          //         ),
          //       ),
          //       const Box.vertical(20),
          //       Container(
          //         color: AppColors.appGrey,
          //         width: 150,
          //         alignment: Alignment.center,
          //         child: Text(
          //           'Twitter widget',
          //           style: context.textTheme.bodyMedium,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // *
          // * Sections
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 15, 23, 15),
                  child: Row(
                    children: [
                      const SectionWidgetTree(),
                      const Box.horizontal(15),
                      const SectionStyles(),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.read<NotifierBloc>().select('0');
                            AppOverlay.removeAll(context);
                          },
                          child: const SectionDisplay(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  right: 20,
                  top: 20,
                  bottom: 20,
                  child: CodeSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    AppOverlay.removeAll(context);
    super.dispose();
  }
}
