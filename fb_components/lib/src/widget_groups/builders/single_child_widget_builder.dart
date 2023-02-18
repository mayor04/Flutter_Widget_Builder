import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/center/fb_center.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/container/fb_container.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/sized_box/fb_sized_box.dart';
import 'package:flutter/material.dart';

import 'fb_widget_type.dart';

/// This class return the widget that matches the styles config provided
/// For Example `FbContainerStyle` would return `Container` with the styles provided
///
/// This should only be used for widget that has single child, for
/// multiple children see `[MultipleChildWidgetBuilder]`
class SingleChildWidgetBuilder extends StatelessWidget {
  final Widget child;
  final BaseFbStyles widgetStyles;
  final VoidCallback onTap;

  const SingleChildWidgetBuilder({
    Key? key,
    required this.child,
    required this.widgetStyles,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: () {
        switch (widgetStyles.widgetType) {
          case FbWidgetType.container:
            return FbContainer(styles: widgetStyles, child: child);
          case FbWidgetType.sizedBox:
            return FbSizedBox(styles: widgetStyles, child: child);
          case FbWidgetType.center:
            return FbCenter(styles: widgetStyles, child: child);
          default:
            return Container();
        }
      }(),
    );
  }
}
