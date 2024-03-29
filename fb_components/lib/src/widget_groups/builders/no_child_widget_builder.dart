import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/params/input_params/input_params.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/divider/fb_divider.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/icon/fb_icon.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/text/fb_text.dart';
import 'package:flutter/material.dart';

import 'fb_widget_type.dart';

/// This class return the widget that matches the styles config provided
/// For Example `FbTextStyle` would return `Text` with the styles provided
///
/// This should only be used for widget that has mo child, for
/// single and multiple children see `MultipleChildWidgetWrapper` and `SingleChildWidgetWrapper`
class NoChildChildWidgetBuilder extends StatelessWidget {
  final BaseFbStyles widgetStyles;
  final VoidCallback onTap;
  final GlobalParamsMap globalParams;

  const NoChildChildWidgetBuilder({
    Key? key,
    required this.widgetStyles,
    required this.onTap,
    required this.globalParams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: () {
        switch (widgetStyles.widgetType) {
          case FbWidgetType.text:
            return FbText(
              styles: widgetStyles,
              globalParams: globalParams,
            );
          case FbWidgetType.divider:
            return FbDivider(styles: widgetStyles);
          case FbWidgetType.icon:
            return FbIcon(styles: widgetStyles);
          default:
            return Container();
        }
      }(),
    );
  }
}
