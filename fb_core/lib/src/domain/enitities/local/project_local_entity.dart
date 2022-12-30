import 'package:hive/hive.dart';

part 'project_local_entity.g.dart';

@HiveType(typeId: 1)
class ProjectLocalEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String desc;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime updatedAt;

  const ProjectLocalEntity({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
  });
}
