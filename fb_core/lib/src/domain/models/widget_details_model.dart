/// Stores the minimal details of a widget
class WidgetDetailsModel {
  final String id;
  final String name;
  final String desc;
  final String projectId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WidgetDetailsModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
  });
}
