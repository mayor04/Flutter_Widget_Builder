import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/domain/enitities/local/widget_data_local_entity.dart';
import 'package:fb_core/src/domain/models/widget_data_model.dart';

class WidgetDataRepository {
  final _localStore = Datastore();
  DatastoreBox<WidgetDataLocalEntity>? _widgetDataBox;

  Future<DatastoreBox<WidgetDataLocalEntity>> _getBox() async =>
      _widgetDataBox ??= await _localStore.openBox<WidgetDataLocalEntity>('widgetDatas');

  Future<WidgetDataModel> get(String id) async {
    final box = await _getBox();
    final widgetData = box.get(id);

    if (widgetData == null) {
      throw Exception('Project not found');
    }

    return widgetData.toModel();
  }

  Future<void> create(WidgetDataModel widgetDataModel) async {
    final box = await _getBox();
    await box.create(widgetDataModel.id, WidgetDataLocalEntity.fromModel(widgetDataModel));
  }

  Future<WidgetDataModel> update(WidgetDataModel widgetDataModel) async {
    final box = await _getBox();
    await box.create(widgetDataModel.id, WidgetDataLocalEntity.fromModel(widgetDataModel));

    return widgetDataModel;
  }

  Future<void> delete() async {}
}
