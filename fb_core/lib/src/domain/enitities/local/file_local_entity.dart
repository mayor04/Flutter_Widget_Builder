import 'package:fb_core/src/domain/enitities/local/base_local_entity.dart';
import 'package:fb_core/src/domain/models/all.dart';
import 'package:hive/hive.dart';

part 'file_local_entity.g.dart';

@HiveType(typeId: 0)
class FileLocalEntity extends LocalEntity<FileModel> {
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

  // from model
  factory FileLocalEntity.fromModel(FileModel fileModel) => FileLocalEntity(
        id: fileModel.id,
        name: fileModel.name,
        desc: fileModel.desc,
        createdAt: fileModel.createdAt,
        updatedAt: fileModel.updatedAt,
        projectId: fileModel.projectId,
      );

  // to model
  @override
  FileModel toModel() => FileModel(
        id: id,
        name: name,
        desc: desc,
        createdAt: createdAt,
        updatedAt: updatedAt,
        projectId: projectId,
      );
}
