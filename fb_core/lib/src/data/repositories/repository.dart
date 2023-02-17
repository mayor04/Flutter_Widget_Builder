import 'package:fb_core/di.dart';
import 'package:fb_core/src/domain/enitities/local/base_local_entity.dart';
import 'package:fb_core/src/services/datastore.dart';
import 'package:meta/meta.dart';

/// All repository should implement this class, based on the approach each
/// repository will have a create, update, delete, get methods
abstract class Repository<Model, Entity extends LocalEntity> {
  final _localStore = gi<Datastore>();
  DatastoreBox<Entity>? _box;

  @internal
  Future<DatastoreBox<Entity>> getLocalDataSource() async =>
      _box ??= await _localStore.openBox<Entity>(Entity.toString());

  Future<Model> get(String id);
  Future<void> create(Model model);
  Future<Model> update(Model model);
  Future<void> delete(String id);
}
