import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/params/params_tab.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/tab_type_enum.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/widget_tree/widget_tree_tab.dart';
import 'package:flutter/material.dart';

class MiniTabView extends StatefulWidget {
  const MiniTabView({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final ValueNotifier<TabType> currentTab;

  @override
  State<MiniTabView> createState() => _MiniTabViewState();
}

class _MiniTabViewState extends State<MiniTabView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: ValueListenableBuilder<TabType>(
        valueListenable: widget.currentTab,
        builder: (context, value, child) {
          switch (value) {
            case TabType.widget:
              return const WidgetTreeTab();
            case TabType.parameters:
              return const ParametersTab();
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
