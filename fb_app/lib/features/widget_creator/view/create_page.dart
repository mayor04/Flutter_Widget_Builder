import 'package:fb_app/features/widget_creator/bloc/notifier_bloc.dart';
import 'package:fb_app/features/widget_creator/tabs/mini_tab_view.dart';
import 'package:fb_app/features/widget_creator/tabs/tab_type_enum.dart';
import 'package:fb_app/features/widget_creator/view/sections/section_display.dart';
import 'package:fb_app/features/widget_creator/view/sections/section_tabs.dart';
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
  final ValueNotifier<TabType> currentTab = ValueNotifier(TabType.widget);
  bool showCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBg,
      body: Column(
        children: [
          // * Sections
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 15, 23, 15),
                  child: Row(
                    children: [
                      SectionTabs(
                        onTabChanged: (tab) => currentTab.value = tab,
                      ),
                      const Box.horizontal(10),
                      MiniTabView(currentTab: currentTab),
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
