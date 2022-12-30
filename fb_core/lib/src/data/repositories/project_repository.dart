import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/domain/enitities/local/project_local_entity.dart';
import 'package:fb_core/src/domain/models/project_model.dart';

class ProjectRepository {
  final localStore = Datastore();
  DatastoreBox<ProjectLocalEntity>? _projectBox;

  Future<DatastoreBox<ProjectLocalEntity>> getBox() async =>
      _projectBox ??= await localStore.openBox<ProjectLocalEntity>('projects');

  Future<void> create(ProjectModel projectModel) async {
    final box = await getBox();
    await box.create(projectModel.id, projectModel.toLocalEntity());
  }

  Future<ProjectModel> update(ProjectModel projectModel) async {
    final box = await getBox();
    await box.create(projectModel.id, projectModel.toLocalEntity());

    return projectModel;
  }

  Future<void> delete() async {}

  Future<List<ProjectModel>> getAll() async {
    final box = await getBox();
    final projects = box.getAll();
    return projects.map((e) => ProjectModel.fromLocalEntity(e)).toList();
  }
}
