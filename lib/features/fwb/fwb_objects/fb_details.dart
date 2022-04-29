import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/core/utils/failure.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

class FbWidgetDetails {
  final log = AppLog('FBdata');

  final int id;
  final FbWidgetType widgetType;

  //Chilren is not made immutable to allow
  List<int> _children;
  List<int> get children => _children;

  //For easy search when
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

  // ///Change children is used only when there is a remove or wrap
  // void changeChildren(List<int> children) {
  //   _children = children;
  // }

  ///Change parent is used only when there is a remove or wrap
  void changeParentId(int parentId) {
    _parentId = parentId;
  }

  bool addWidgetId(int id) {
    if (childType == FbChildType.none) {
      throw Exception('No child widget cant have children');
    }

    if (childType == FbChildType.single && children.isNotEmpty) {
      throw Exception('Single widget cant have multiple children');
    }

    children.add(id);
    return true;
  }

  bool replaceWidgetId(int formerId, int newId) {
    try {
      var formerIndex = children.indexOf(formerId);
      children[formerIndex] = newId;
    } catch (e) {
      throw Failure('Cannot replace child $formerId wih $newId');
    }

    return true;
  }

  bool removeWidgetId(int id) {
    return children.remove(id);
  }

  int? childAt(index) {
    return children.itemAt(index);
  }

  int? get firstChildId {
    return childAt(0);
  }
}
