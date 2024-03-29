import 'package:fb_components/fb_components.dart';
import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/column/fb_column_input.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/row/fb_row_config.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/row/fb_row_input.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/stack/fb_stack_config.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/stack/fb_stack_input.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/divider/fb_divider_config.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/divider/fb_divider_input.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/icon/fb_icon_config.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/icon/fb_icon_input.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/text/fb_text_config.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/text/fb_text_input.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/expanded/fb_expanded_config.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/expanded/fb_expanded_input.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/positioned/fb_positioned_config.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/positioned/fb_positioned_input.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/center/fb_center_config.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/center/fb_center_input.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/container/fb_container_input.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/sized_box/fb_sized_box_config.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/sized_box/fb_sized_box_input.dart';
import 'package:flutter/material.dart';

/// Receives a style and callback and builds the corresponding input widget
/// For instance when container widget is clicked it retrieves the styles
/// passes it to the input builder which builds the widget
// TO-CREATE - edit this
class FbInputBuilderWidget extends StatelessFbInput<BaseFbStyles> {
  const FbInputBuilderWidget({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
    required super.globalParams,
  });

  @override
  Widget build(BuildContext context) {
    switch (styles.widgetType) {
      case FbWidgetType.container:
        return FbContainerInput(
          styles: styles as FbContainerStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.column:
        return FbColumnInput(
          styles: styles as FbColumnStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.row:
        return FbRowInput(
          styles: styles as FbRowStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.text:
        return FbTextInput(
          styles: styles as FbTextStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.expanded:
        return FbExpandedInput(
          styles: styles as FbExpandedStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.positioned:
        return FbPositionedInput(
          styles: styles as FbPositionedStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.sizedBox:
        return FbSizedBoxInput(
          styles: styles as FbSizedBoxStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.stack:
        return FbStackInput(
          styles: styles as FbStackStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.divider:
        return FbDividerInput(
          styles: styles as FbDividerStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.icon:
        return FbIconInput(
          styles: styles as FbIconStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      case FbWidgetType.center:
        return FbCenterInput(
          styles: styles as FbCenterStyles,
          onStylesUpdated: onStylesUpdated,
          globalParams: globalParams,
        );
      default:
        throw (Exception('Widget config is not available'));
    }
  }
}
