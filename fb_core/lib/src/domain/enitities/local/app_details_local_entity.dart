import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/domain/enitities/local/base_local_entity.dart';
import 'package:hive/hive.dart';

part 'app_details_local_entity.g.dart';

@HiveType(typeId: 1)
class AppDetailsLocalEntity extends LocalEntity<AppDetailsModel> {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String desc;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime updatedAt;

  const AppDetailsLocalEntity({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppDetailsLocalEntity.fromModel(AppDetailsModel projectModel) => AppDetailsLocalEntity(
        id: projectModel.id,
        name: projectModel.name,
        desc: projectModel.desc,
        createdAt: projectModel.createdAt,
        updatedAt: projectModel.updatedAt,
      );

  @override
  AppDetailsModel toModel() => AppDetailsModel(
        id: id,
        name: name,
        desc: desc,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
