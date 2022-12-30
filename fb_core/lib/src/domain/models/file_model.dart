import 'package:fb_core/src/domain/enitities/local/file_local_entity.dart';

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

  FileLocalEntity toLocalEntity() {
    return FileLocalEntity(
      id: id,
      name: name,
      desc: desc,
      createdAt: createdAt,
      updatedAt: updatedAt,
      projectId: projectId,
    );
  }

  factory FileModel.fromLocalEntity(FileLocalEntity entity) {
    return FileModel(
      id: entity.id,
      name: entity.name,
      desc: entity.desc,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      projectId: entity.projectId,
    );
  }
}
