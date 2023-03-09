import 'package:fb_core/src/domain/enitities/local/base_local_entity.dart';
import 'package:fb_core/src/domain/models/widget_ui_model.dart';
import 'package:hive/hive.dart';

part 'widget_ui_local_entity.g.dart';

@HiveType(typeId: 2)
class WidgetUILocalEntity extends LocalEntity<WidgetUIModel> {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<String> idList;

  @HiveField(2)
  final Map<String, Map<String, dynamic>> fbConfigMap;

  @HiveField(3)
  final Map<String, Map<String, dynamic>> fbDetailsMap;

  @HiveField(4, defaultValue: {})
  final Map<String, Map<String, dynamic>>? parameters;

  WidgetUILocalEntity({
    required this.id,
    required this.idList,
    required this.fbConfigMap,
    required this.fbDetailsMap,
    required this.parameters,
  });

  factory WidgetUILocalEntity.fromModel(WidgetUIModel widgetDataModel) => WidgetUILocalEntity(
        id: widgetDataModel.id,
        idList: widgetDataModel.idList,
        fbConfigMap: widgetDataModel.fbConfigMap,
        fbDetailsMap: widgetDataModel.fbDetailsMap,
        parameters: widgetDataModel.parameters,
      );

  @override
  WidgetUIModel toModel() => WidgetUIModel(
        id: id,
        idList: idList,
        fbConfigMap: fbConfigMap,
        fbDetailsMap: fbDetailsMap,
        parameters: parameters ?? {},
      );
}
