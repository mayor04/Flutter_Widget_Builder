import 'package:fb_core/src/domain/models/widget_data_model.dart';
import 'package:hive/hive.dart';

part 'widget_data_local_entity.g.dart';

@HiveType(typeId: 2)
class WidgetDataLocalEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<String> idList;

  @HiveField(2)
  final Map<String, Map<String, dynamic>> fbConfigMap;

  @HiveField(3)
  final Map<String, Map<String, dynamic>> fbDetailsMap;

  WidgetDataLocalEntity({
    required this.id,
    required this.idList,
    required this.fbConfigMap,
    required this.fbDetailsMap,
  });

  factory WidgetDataLocalEntity.fromModel(WidgetDataModel widgetDataModel) => WidgetDataLocalEntity(
        id: widgetDataModel.id,
        idList: widgetDataModel.idList,
        fbConfigMap: widgetDataModel.fbConfigMap,
        fbDetailsMap: widgetDataModel.fbDetailsMap,
      );

  WidgetDataModel toModel() => WidgetDataModel(
        id: id,
        idList: idList,
        fbConfigMap: fbConfigMap,
        fbDetailsMap: fbDetailsMap,
      );
}
