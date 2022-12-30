import 'package:hive/hive.dart';

part 'file_local_entity.g.dart';

@HiveType(typeId: 0)
class FileLocalEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String desc;

  @HiveField(3)
  final String projectId;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime updatedAt;

  const FileLocalEntity({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
  });
}
