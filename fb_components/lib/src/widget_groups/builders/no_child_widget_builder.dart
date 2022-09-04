import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/text/fb_text.dart';
import 'package:flutter/material.dart';

/// This class return the widget that matches the styles config provided
/// For Example `FbTextStyle` would return `Text` with the styles provided
///
/// This should only be used for widget that has mo child, for
/// single and multiple children see `MultipleChildWidgetWrapper` and `SingleChildWidgetWrapper`
class NoChildChildWidgetBuilder extends StatelessWidget {
  final BaseFbStyles widgetStyles;
  final VoidCallback onTap;

  const NoChildChildWidgetBuilder({
    Key? key,
    required this.widgetStyles,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: () {
        switch (widgetStyles.widgetType) {
          case FbWidgetType.text:
            return FbText(styles: widgetStyles);
          default:
            return Container();
        }
      }(),
    );
  }
}
