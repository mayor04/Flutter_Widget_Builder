import 'package:fb_core/src/data/repositories/repository.dart';
import 'package:fb_core/src/domain/enitities/local/app_details_local_entity.dart';
import 'package:fb_core/src/domain/models/app_details_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppDetailsRepository extends Repository<AppDetailsModel, AppDetailsLocalEntity> {
  @override
  Future<AppDetailsModel> get(String id) async {
    final box = await getLocalDataSource();
    final project = box.get(id);

    if (project == null) {
      throw Exception('Project not found');
    }

    return project.toModel();
  }

  @override
  Future<void> create(AppDetailsModel model) async {
    final box = await getLocalDataSource();
    await box.create(model.id, AppDetailsLocalEntity.fromModel(model));
  }

  @override
  Future<AppDetailsModel> update(AppDetailsModel model) async {
    final box = await getLocalDataSource();
    await box.create(model.id, AppDetailsLocalEntity.fromModel(model));

    return model;
  }

  @override
  Future<void> delete(String id) async {}

  Future<List<AppDetailsModel>> getAll() async {
    final box = await getLocalDataSource();
    final projects = box.getAll();
    return projects.map((e) => e.toModel()).toList();
  }
}
