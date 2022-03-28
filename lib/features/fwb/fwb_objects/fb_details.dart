import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

class FbWidgetDetails {
  final log = AppLog('FBdata');

  final int id;
  final FbWidgetType widgetType;
  final List<int> children;

  ///Widget Data holds the style of the widget
  final FbWidgetStylesCallback? widgetStylesCallback;

  /// Represent the how the widget is in the tree.
  /// The topmost widget is `0` and child `1` any subsequent child added
  /// Should increament the level
  /// This
  final int levelInTree;
  final FbChildType childType;

  String get name {
    return widgetType.name.capitalizeFirst;
  }

  bool get hasChild {
    return children.isNotEmpty;
  }

  int? childAt(index) {
    return children.itemAt(index);
  }

  FbWidgetDetails({
    required this.id,
    required this.widgetType,
    required this.children,
    required this.levelInTree,
    this.widgetStylesCallback,
    this.childType = FbChildType.single,
  });

  BaseFbStyles get styles {
    assert(widgetStylesCallback != null);

    return widgetStylesCallback!();
  }

  bool addWidget(id) {
    if (childType == FbChildType.single && children.isNotEmpty) {
      throw Exception('Single widget cant have multiple children');
    }

    children.add(id);
    return true;
  }
}
