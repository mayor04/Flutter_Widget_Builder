import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/domain/enitities/local/file_local_entity.dart';

class FilesRepository {
  final _localStore = Datastore();
  DatastoreBox<FileLocalEntity>? _fileBox;

  Future<DatastoreBox<FileLocalEntity>> _getBox() async =>
      _fileBox ??= await _localStore.openBox<FileLocalEntity>('files');

  Future<FileModel> get(String id) async {
    final box = await _getBox();
    final file = box.get(id);

    if (file == null) {
      throw Exception('Project not found');
    }

    return file.toModel();
  }

  Future<void> create(FileModel fileModel) async {
    final box = await _getBox();
    await box.create(fileModel.id, FileLocalEntity.fromModel(fileModel));
  }

  Future<FileModel> update(FileModel fileModel) async {
    final box = await _getBox();
    await box.create(fileModel.id, FileLocalEntity.fromModel(fileModel));

    return fileModel;
  }

  Future<void> delete() async {}

  Future<List<FileModel>> getFilesLinkedToProject(String projectId) async {
    final box = await _getBox();
    final files = box.getAll();
    return files.map((e) => e.toModel()).toList();
  }
}
