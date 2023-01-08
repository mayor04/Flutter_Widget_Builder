class WidgetDataModel {
  final String id;
  final List<String> idList;
  final Map<String, Map<String, dynamic>> fbConfigMap;
  final Map<String, Map<String, dynamic>> fbDetailsMap;

  WidgetDataModel({
    required this.id,
    required this.idList,
    required this.fbConfigMap,
    required this.fbDetailsMap,
  });
}
