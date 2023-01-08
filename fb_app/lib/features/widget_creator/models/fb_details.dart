import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';

class FbWidgetDetails {
  final log = AppLog('FBdata');

  final String id;
  final FbWidgetType widgetType;

  // Both parent and children can be changed since removing doe
  // Chilren is not made immutable to allow changing children
  List<String> _children;
  List<String> get children => _children;

  // For easy search when
  String _parentId;
  String get parentId => _parentId;

  /// Represent the how the widget is in the tree.
  /// The topmost widget is `0` and child `1` any subsequent child added
  /// Should increament the level
  /// TODO: when the remove method is called we might run into issues with level in tree
  final int levelInTree;
  final FbChildType childType;

  FbWidgetDetails({
    required this.id,
    required this.widgetType,
    required List<String> children,
    required this.levelInTree,
    required String parentId,
    this.childType = FbChildType.single,
  })  : _children = children,
        _parentId = parentId;

  // FROM json
  factory FbWidgetDetails.fromJson(Map<String, dynamic> json) {
    return FbWidgetDetails(
      id: json['id'],
      widgetType: FbWidgetType.values.firstWhere((e) => e.name == json['widgetType']),
      children: (json['children'] as List<dynamic>).cast<String>(),
      levelInTree: json['levelInTree'] as int,
      parentId: json['parentId'] as String,
      childType: FbChildType.values.firstWhere((e) => e.name == json['childType']),
    );
  }

  bool get hasChild {
    return children.isNotEmpty;
  }

  String get name {
    return widgetType.name.capitalizeFirst;
  }

  /// Change children is used only when there is a wrap
  void changeChildren(List<String> children) {
    _children = children;
  }

  /// Replace childId with another child id
  void replaceChild(String id, String? replaceId) {
    final index = _children.indexOf(id);
    if (replaceId == null) {
      _children.removeAt(index);
      return;
    }

    _children.replaceRange(index, index + 1, [replaceId]);
  }

  ///Change parent is used only when there is a remove or wrap
  void changeParentId(String parentId) {
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

  String? childAt(index) {
    return children.itemAt(index);
  }

  String? get firstChildId {
    return childAt(0);
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'widgetType': widgetType.name,
      'children': children,
      'levelInTree': levelInTree,
      'parentId': parentId,
      'childType': childType.name,
    };
  }
}
