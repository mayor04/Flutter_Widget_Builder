import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_widget_builder/features/widget_creator/controller/interface_controller.dart';

class FbWidgetDetails {
  final log = AppLog('FBdata');

  final int id;
  final FbWidgetType widgetType;

  // Both parent and children can be changed since removing doe
  // Chilren is not made immutable to allow changing children
  List<int> _children;
  List<int> get children => _children;

  // For easy search when
  int _parentId;
  int get parentId => _parentId;

  ///Widget Data holds the style of the widget
  final FbWidgetStylesCallback? widgetStylesCallback;

  /// Represent the how the widget is in the tree.
  /// The topmost widget is `0` and child `1` any subsequent child added
  /// Should increament the level
  /// TODO: when the remove method is called we might run into issues with level in tree
  final int levelInTree;
  final FbChildType childType;

  FbWidgetDetails({
    required this.id,
    required this.widgetType,
    required List<int> children,
    required this.levelInTree,
    required int parentId,
    this.widgetStylesCallback,
    this.childType = FbChildType.single,
  })  : _children = children,
        _parentId = parentId;

  bool get hasChild {
    return children.isNotEmpty;
  }

  String get name {
    return widgetType.name.capitalizeFirst;
  }

  BaseFbStyles get styles {
    assert(widgetStylesCallback != null);

    return widgetStylesCallback!();
  }

  /// Change children is used only when there is a remove or wrap
  void changeChildren(List<int> children) {
    _children = children;
  }

  ///Change parent is used only when there is a remove or wrap
  void changeParentId(int parentId) {
    _parentId = parentId;
  }

  bool addWidget(id) {
    if (childType == FbChildType.none) {
      throw Exception('No child widget cant have children');
    }

    if (childType == FbChildType.single && children.isNotEmpty) {
      throw Exception('Single widget cant have multiple children');
    }

    children.add(id);
    return true;
  }

  int? childAt(index) {
    return children.itemAt(index);
  }

  int? get firstChildId {
    return childAt(0);
  }
}
