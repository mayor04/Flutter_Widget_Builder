import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/column/fb_column.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/row/fb_row.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/stack/fb_stack.dart';
import 'package:flutter/material.dart';

/// This class return the widget that matches the styles config provided
/// For Example `FbColumnStyle` would return `Column` with the styles provided
///
/// This should only be used for widget that has multiple children, for
/// single children see `SingleChildWidgetBuilder`
class MultipleChildWidgetBuilder extends StatelessWidget {
  final List<Widget> children;
  final BaseFbStyles widgetStyles;
  final VoidCallback onTap;

  const MultipleChildWidgetBuilder({
    Key? key,
    required this.children,
    required this.widgetStyles,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: () {
        switch (widgetStyles.widgetType) {
          case FbWidgetType.column:
            return FbColumn(styles: widgetStyles, children: children);
          case FbWidgetType.row:
            return FbRow(styles: widgetStyles, children: children);
          case FbWidgetType.stack:
            return FbStack(styles: widgetStyles, children: children);
          default:
            return Container();
        }
      }(),
    );
  }
}
