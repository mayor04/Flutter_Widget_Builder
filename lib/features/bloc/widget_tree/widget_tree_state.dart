part of 'widget_tree_bloc.dart';

enum WidgetTreeAction { none, add, remove, wrap, delete }

class WidgetTreeState {
  final Map<int, FbWidgetDetails> fbDetailsMap;
  final WidgetTreeAction? action;
  final int? widgetId;
  final int? parentId;

  WidgetTreeState({
    required this.fbDetailsMap,
    this.action = WidgetTreeAction.none,
    this.widgetId,
    this.parentId,
  });

  ///Return the first widget in the tree
  FbWidgetDetails? get firstWidgetDetails {
    var firstWidgetId = fbDetailsMap[xMainId]?.children[0];
    var firstWidgetData = fbDetailsMap[firstWidgetId];

    if (firstWidgetData == null && fbDetailsMap.length > 1) {
      AppLog.warn('get firstWidgetData', 'Could not get first widget in list');
    }

    return firstWidgetData;
  }
}
