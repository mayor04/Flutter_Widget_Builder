import 'package:fb_core/src/domain/enitities/local/project_local_entity.dart';

class ProjectModel {
  final String id;
  final String name;
  final String desc;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
  });

  ProjectLocalEntity toLocalEntity() {
    return ProjectLocalEntity(
      id: id,
      name: name,
      desc: desc,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ProjectModel.fromLocalEntity(ProjectLocalEntity entity) {
    return ProjectModel(
      id: entity.id,
      name: entity.name,
      desc: entity.desc,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
