import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';

class FbData {
  final log = AppLog('FBdata');

  final int id;
  final FbWidgetType widgetType;
  final List<int> children;

  /// Represent the how the widget is in the tree.
  /// The topmost widget is `0` and child `1` any subsequent child added
  /// Should increament the level
  final int levelInTree;
  final FbChildType childType;

  String get name {
    return widgetType.name.capitalizeFirst;
  }

  FbData({
    required this.id,
    required this.widgetType,
    required this.children,
    required this.levelInTree,
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