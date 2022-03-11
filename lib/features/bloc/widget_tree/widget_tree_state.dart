part of 'widget_tree_bloc.dart';

class WidgetTreeState {
  final Map<int, FbData> fbDataMap;

  const WidgetTreeState(this.fbDataMap);

  ///Return the first widget in the tree
  FbData? get firstWidgetData {
    var firstWidgetId = fbDataMap[xMainId]?.children[0];
    var firstWidgetData = fbDataMap[firstWidgetId];

    if (firstWidgetData == null && fbDataMap.length > 1) {
      AppLog.warn('get firstWidgetData', 'Could not get first widget in list');
    }

    return firstWidgetData;
  }
}
