import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/data/repositories/repository.dart';
import 'package:fb_core/src/domain/enitities/local/widget_details_local_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class WidgetDetailsRepository extends Repository<WidgetDetailsModel, WidgetDetailsLocalEntity> {
  @override
  Future<WidgetDetailsModel> get(String id) async {
    final box = await getLocalDataSource();
    final file = box.get(id);

    if (file == null) {
      throw Exception('Project not found');
    }

    return file.toModel();
  }

  @override
  Future<void> create(WidgetDetailsModel model) async {
    final box = await getLocalDataSource();
    await box.create(model.id, WidgetDetailsLocalEntity.fromModel(model));
  }

  @override
  Future<WidgetDetailsModel> update(WidgetDetailsModel model) async {
    final box = await getLocalDataSource();
    await box.create(model.id, WidgetDetailsLocalEntity.fromModel(model));

    return model;
  }

  @override
  Future<void> delete(String id) async {}

  Future<List<WidgetDetailsModel>> getFilesLinkedToProject(String projectId) async {
    final box = await getLocalDataSource();
    final files = box.getAll();
    return files.map((e) => e.toModel()).toList();
  }
}
