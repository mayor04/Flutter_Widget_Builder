class FileModel {
  final String id;
  final String name;
  final String desc;
  final String projectId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FileModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
  });
}
