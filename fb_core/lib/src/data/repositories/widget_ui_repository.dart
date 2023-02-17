import 'package:fb_core/src/data/repositories/repository.dart';
import 'package:fb_core/src/domain/enitities/local/widget_ui_local_entity.dart';
import 'package:fb_core/src/domain/models/widget_ui_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class WidgetUIRepository extends Repository<WidgetUIModel, WidgetUILocalEntity> {
  @override
  Future<WidgetUIModel> get(String id) async {
    final box = await getLocalDataSource();
    final widgetData = box.get(id);

    if (widgetData == null) {
      throw Exception('Project not found');
    }

    return widgetData.toModel();
  }

  @override
  Future<void> create(WidgetUIModel model) async {
    final box = await getLocalDataSource();
    await box.create(model.id, WidgetUILocalEntity.fromModel(model));
  }

  @override
  Future<WidgetUIModel> update(WidgetUIModel model) async {
    final box = await getLocalDataSource();
    await box.create(model.id, WidgetUILocalEntity.fromModel(model));

    return model;
  }

  @override
  Future<void> delete(String id) async {}
}
