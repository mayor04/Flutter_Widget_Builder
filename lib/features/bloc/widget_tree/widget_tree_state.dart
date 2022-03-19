part of 'widget_tree_bloc.dart';

class WidgetTreeState {
  final Map<int, FbWidgetDetails> fbDetailsMap;

  const WidgetTreeState(this.fbDetailsMap);

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
