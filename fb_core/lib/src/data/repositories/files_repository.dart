import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/domain/enitities/local/file_local_entity.dart';

class FilesRepository {
  final localStore = Datastore();
  DatastoreBox<FileLocalEntity>? _fileBox;

  Future<DatastoreBox<FileLocalEntity>> getBox() async =>
      _fileBox ??= await localStore.openBox<FileLocalEntity>('files');

  Future<void> create(FileModel fileModel) async {
    final box = await getBox();
    await box.create(fileModel.id, fileModel.toLocalEntity());
  }

  Future<FileModel> update(FileModel fileModel) async {
    final box = await getBox();
    await box.create(fileModel.id, fileModel.toLocalEntity());

    return fileModel;
  }

  Future<void> delete() async {}

  Future<List<FileModel>> getFilesLinkedToProject(String projectId) async {
    final box = await getBox();
    final files = box.getAll();
    return files.map((e) => FileModel.fromLocalEntity(e)).toList();
  }
}
