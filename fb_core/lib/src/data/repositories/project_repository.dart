import 'package:fb_core/src/domain/enitities/local/project_local_entity.dart';
import 'package:fb_core/src/domain/models/project_model.dart';
import 'package:fb_core/src/services/datastore.dart';

class ProjectRepository {
  final _localStore = Datastore();
  DatastoreBox<ProjectLocalEntity>? _projectBox;

  Future<DatastoreBox<ProjectLocalEntity>> _getBox() async =>
      _projectBox ??= await _localStore.openBox<ProjectLocalEntity>('projects');

  Future<ProjectModel> get(String id) async {
    final box = await _getBox();
    final project = box.get(id);

    if (project == null) {
      throw Exception('Project not found');
    }

    return project.toModel();
  }

  Future<void> create(ProjectModel projectModel) async {
    final box = await _getBox();
    await box.create(projectModel.id, ProjectLocalEntity.fromModel(projectModel));
  }

  Future<ProjectModel> update(ProjectModel projectModel) async {
    final box = await _getBox();
    await box.create(projectModel.id, ProjectLocalEntity.fromModel(projectModel));

    return projectModel;
  }

  Future<void> delete() async {}

  Future<List<ProjectModel>> getAll() async {
    final box = await _getBox();
    final projects = box.getAll();
    return projects.map((e) => e.toModel()).toList();
  }
}
