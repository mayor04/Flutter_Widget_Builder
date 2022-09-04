import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/expanded/fb_expanded.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/positioned/fb_positioned.dart';
import 'package:flutter/material.dart';

/// This class return the widget that matches the styles config provided
/// For Example `FbExpandedStyle` would return `Expanded` with the styles provided
///
/// This should only be used for widget that has depends directly
/// on their parent for example expanded and positioned
class ParentDataWidgetBuilder extends StatelessWidget {
  final Widget child;
  final BaseFbStyles widgetStyles;

  const ParentDataWidgetBuilder({
    Key? key,
    required this.child,
    required this.widgetStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (widgetStyles.widgetType) {
      case FbWidgetType.positioned:
        return FbPositioned(styles: widgetStyles, child: child);
      case FbWidgetType.expanded:
        return FbExpanded(styles: widgetStyles, child: child);
      default:
        return Container();
    }
  }
}
