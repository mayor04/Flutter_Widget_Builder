/// Contains the UI of the widget used to display the widget
class WidgetUIModel {
  final String id;
  final List<String> idList;
  final Map<String, Map<String, dynamic>> fbConfigMap;
  final Map<String, Map<String, dynamic>> fbDetailsMap;
  final Map<String, Map<String, dynamic>> parameters;

  WidgetUIModel({
    required this.id,
    required this.idList,
    required this.fbConfigMap,
    required this.fbDetailsMap,
    required this.parameters,
  });
}
