import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_column_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container_config.dart';

///This class return the widget that matches the styles config provided
///For Example `FbContainerStyle` would return `Container` with the styles provided
///
///This should only be used for widget that has single child, for
///multiple children see `MultipleChildWidgetWrapper`
class SingleChildWidgetMapper extends StatelessWidget {
  final Widget child;
  final BaseFbStyles widgetStyles;

  const SingleChildWidgetMapper({
    Key? key,
    required this.child,
    required this.widgetStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _SingleWidgetMapFunction? mapFunction =
        _WidgetMap.single[widgetStyles.widgetType];

    assert(mapFunction != null);
    return mapFunction!(widgetStyles, child);
  }
}

///This class return the widget that matches the styles config provided
///For Example `FbColumnStyle` would return `Column` with the styles provided
///
///This should only be used for widget that has multiple children, for
///single children see `SingleChildWidgetWrapper`
class MultipleChildWidgetMapper extends StatelessWidget {
  final List<Widget> children;
  final BaseFbStyles widgetStyles;

  const MultipleChildWidgetMapper({
    Key? key,
    required this.children,
    required this.widgetStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _MultipleWidgetMapFunction? mapFunction =
        _WidgetMap.multiple[widgetStyles.widgetType];

    assert(mapFunction != null);
    return mapFunction!(widgetStyles, children);
  }
}

typedef _SingleWidgetMapFunction = Widget Function(BaseFbStyles, Widget child);

typedef _MultipleWidgetMapFunction = Widget Function(
    BaseFbStyles, List<Widget> child);

class _WidgetMap {
  static final Map<FbWidgetType, _SingleWidgetMapFunction> single = {
    FbWidgetType.container: (styles, child) {
      var containerStyles = styles.cast<FbContainerStyles>();

      return Container(
        height: containerStyles.height,
        width: containerStyles.width,
        color: Color(containerStyles.colorValue),
        child: child,
      );
    },
  };

  static final Map<FbWidgetType, _MultipleWidgetMapFunction> multiple = {
    FbWidgetType.column: (styles, children) {
      var columnStyles = styles.cast<FbColumnStyles>();

      return Column(
        children: children,
      );
    },
    FbWidgetType.row: (styles, children) {
      // var rowStyles = styles.cast<FbRowStyles>();

      return Row(
        children: children,
      );
    },
  };
}
