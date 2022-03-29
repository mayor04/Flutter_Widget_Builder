import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/all.dart';

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
    _SingleWidgetMapBuilder? mapBuilder =
        _WidgetMap.single[widgetStyles.widgetType];

    assert(mapBuilder != null);
    return mapBuilder!(widgetStyles, child);
  }
}

//The positioned widget needs to be placed directly under a stack
//With the current architecture the widget is first wrapped in a container
//before it is placed. So we are basically creating another stack with
//the parent(which is a stack) style and adding the child as the positioned widget
//
///This approach is more like a quick fix and would be later refactored
class PositionedChildWidgetMapper extends StatelessWidget {
  final Widget child;
  final BaseFbStyles widgetStyle;
  final BaseFbStyles parentStyle;

  const PositionedChildWidgetMapper({
    Key? key,
    required this.child,
    required this.widgetStyle,
    required this.parentStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _MultipleWidgetMapBuilder? parentBuilder =
        _WidgetMap.multiple[parentStyle.widgetType];

    _SingleWidgetMapBuilder? childBuilder =
        _WidgetMap.single[widgetStyle.widgetType];

    assert(childBuilder != null);
    assert(parentBuilder != null);

    return parentBuilder!(
      parentStyle,
      [childBuilder!(widgetStyle, child)],
    );
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
    _MultipleWidgetMapBuilder? mapBuilder =
        _WidgetMap.multiple[widgetStyles.widgetType];

    assert(mapBuilder != null);
    return mapBuilder!(widgetStyles, children);
  }
}

///This class return the widget that matches the styles config provided
///For Example `FbTextStyle` would return `Text` with the styles provided
///
///This should only be used for widget that has mo child, for
///single and multiple children see `MultipleChildWidgetWrapper` and `SingleChildWidgetWrapper`
class NoChildChildWidgetMapper extends StatelessWidget {
  final BaseFbStyles widgetStyles;

  const NoChildChildWidgetMapper({
    Key? key,
    required this.widgetStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _NoChildMapBuilder? mapBuilder =
        _WidgetMap.noChild[widgetStyles.widgetType];

    assert(mapBuilder != null);
    return mapBuilder!(widgetStyles);
  }
}

typedef _SingleWidgetMapBuilder = Widget Function(BaseFbStyles, Widget child);

typedef _MultipleWidgetMapBuilder = Widget Function(
    BaseFbStyles, List<Widget> child);

typedef _NoChildMapBuilder = Widget Function(BaseFbStyles);

class _WidgetMap {
  static final Map<FbWidgetType, _NoChildMapBuilder> noChild = {
    FbWidgetType.text: (styles) {
      var textStyles = styles.cast<FbTextStyles>();

      return Text(
        textStyles.text == '' ? 'Enter Text' : textStyles.text,
        style: TextStyle(
          fontSize: textStyles.fontSize,
          color: Color(textStyles.colorValue),
          fontWeight: textStyles.fontWeight,
        ),
      );
    },
  };

  static final Map<FbWidgetType, _SingleWidgetMapBuilder> single = {
    FbWidgetType.container: (styles, child) {
      var containerStyles = styles.cast<FbContainerStyles>();

      return Container(
        padding: containerStyles.padding,
        margin: containerStyles.margin,
        height: containerStyles.height,
        width: containerStyles.width,
        alignment: containerStyles.alignment,
        decoration: BoxDecoration(
          color: Color(containerStyles.colorValue),
          borderRadius: containerStyles.borderRadius,
          border: containerStyles.border,
        ),
        child: child,
      );
    },
    FbWidgetType.sizedBox: (styles, child) {
      var sizedBoxStyles = styles.cast<FbSizedBoxStyles>();

      return SizedBox(
        height: sizedBoxStyles.height,
        width: sizedBoxStyles.width,
        child: child,
      );
    },
    FbWidgetType.positioned: (styles, child) {
      var positionedStyles = styles.cast<FbPositionedStyles>();

      return Positioned(
        top: positionedStyles.top,
        bottom: positionedStyles.bottom,
        left: positionedStyles.left,
        right: positionedStyles.right,
        child: child,
      );
    },
    FbWidgetType.expanded: (styles, child) {
      var expandedStyles = styles.cast<FbExpandedStyles>();

      return Expanded(
        flex: expandedStyles.flex,
        child: child,
      );
    },
  };

  static final Map<FbWidgetType, _MultipleWidgetMapBuilder> multiple = {
    FbWidgetType.column: (styles, children) {
      var columnStyles = styles.cast<FbColumnStyles>();

      return Column(
        mainAxisAlignment: columnStyles.mainAlignment,
        crossAxisAlignment: columnStyles.crossAlignment,
        mainAxisSize: columnStyles.axisSize,
        children: children,
      );
    },
    FbWidgetType.row: (styles, children) {
      var rowStyles = styles.cast<FbRowStyles>();

      return Row(
        mainAxisAlignment: rowStyles.mainAlignment,
        crossAxisAlignment: rowStyles.crossAlignment,
        mainAxisSize: rowStyles.axisSize,
        children: children,
      );
    },
    FbWidgetType.stack: (styles, children) {
      var stackStyles = styles.cast<FbStackStyles>();

      return Stack(
        fit: stackStyles.stackFit,
        children: children,
      );
    },
  };
}
