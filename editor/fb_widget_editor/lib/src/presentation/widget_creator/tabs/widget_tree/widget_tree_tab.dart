import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/widget_tree/section_styles.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/widget_tree/section_widget_tree.dart';
import 'package:flutter/material.dart';

class WidgetTreeTab extends StatelessWidget {
  const WidgetTreeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SectionWidgetTree(),
        SizedBox(width: 15),
        SectionStyles(),
      ],
    );
  }
}
