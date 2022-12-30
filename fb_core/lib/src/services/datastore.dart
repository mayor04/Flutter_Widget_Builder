import 'package:fb_core/src/domain/enitities/local/files_local_entity.dart';
import 'package:fb_core/src/domain/enitities/local/project_local_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

// A wrapper around local storage (hive)
class Datastore {
  static Future<void> initStorage() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProjectLocalEntityAdapter());
    Hive.registerAdapter(FilesLocalEntityAdapter());
  }

  Future<DatastoreBox<E>> openBox<E>(String boxName) async {
    final box = await Hive.openBox<E>(boxName);
    return DatastoreBox(boxName, box);
  }

  DatastoreBox<E> box<E>(String boxName) {
    final box = Hive.box<E>(boxName);
    return DatastoreBox(boxName, box);
  }

  Future<void> closeBox(String boxName) async {
    await Hive.box(boxName).close();
  }

  Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }

  Future<void> deleteAllBoxes() async {
    await Hive.deleteFromDisk();
  }
}

class DatastoreBox<E> {
  final String name;
  final Box<E> box;

  DatastoreBox(this.name, this.box);

  Future<void> create(String key, E value) async {
    await box.put(key, value);
  }

  Future<void> update(String key, E value) async {
    await box.put(key, value);
  }

  Future<void> delete(String key) async {
    await box.delete(key);
  }

  E? get(dynamic key, {E? defaultValue}) {
    return box.get(key, defaultValue: defaultValue);
  }

  List<dynamic> getAll() {
    return box.values.toList();
  }
}


/* ~NOTE~ We have (project_box) (widget_meta_box) (widget_ui_box)

- The project box stores all the project the user has created
    - id, Name, Created At, Updated At, Desc
- The widget meta box stores 
    - id, Name, Project title Created At, Updated At, Desc
- The widget ui box stores the actual data used for displaying the widget
  this data is gotten from the widget interface controller and then 
  restored when the widget is opened 
*/