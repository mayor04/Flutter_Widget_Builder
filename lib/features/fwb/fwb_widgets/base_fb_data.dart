import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';

class FbWidgetDetails {
  final log = AppLog('FBdata');

  final int id;
  final FbWidgetType widgetType;
  final List<int> children;

  ///Widget Data holds the style of the widget
  final FbWidgetDataCallback widgetDataCallback;

  /// Represent the how the widget is in the tree.
  /// The topmost widget is `0` and child `1` any subsequent child added
  /// Should increament the level
  final int levelInTree;
  final FbChildType childType;

  String get name {
    return widgetType.name.capitalizeFirst;
  }

  FbWidgetDetails({
    required this.id,
    required this.widgetType,
    required this.children,
    required this.levelInTree,
    required this.widgetDataCallback,
    this.childType = FbChildType.single,
  });

  bool addWidget(id) {
    assert(() {
      if (childType == FbChildType.single && children.isNotEmpty) {
        throw Exception('Single widget cant have multiple children');
      }
      return true;
    }());

    children.add(id);
    return true;
  }
}
