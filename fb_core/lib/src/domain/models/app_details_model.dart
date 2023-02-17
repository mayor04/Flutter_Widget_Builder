class AppDetailsModel {
  final String id;
  final String name;
  final String desc;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AppDetailsModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
  });
}
