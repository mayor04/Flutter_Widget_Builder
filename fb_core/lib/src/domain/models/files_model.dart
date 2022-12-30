import 'package:fb_core/src/domain/enitities/local/files_local_entity.dart';

class FilesModel {
  final String id;
  final String name;
  final String desc;
  final String projectId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FilesModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
  });

  FilesLocalEntity toLocalEntity() {
    return FilesLocalEntity(
      id: id,
      name: name,
      desc: desc,
      createdAt: createdAt,
      updatedAt: updatedAt,
      projectId: projectId,
    );
  }
}
