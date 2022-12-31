import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_core/fb_core.dart';
import 'package:meta/meta.dart';

part 'file_list_state.dart';

class FileListBloc extends Cubit<FileListState> {
  FileListBloc() : super(const FileListState(fileList: [], projectName: ''));

  final FilesRepository _fileRepo = FilesRepository();
  final ProjectRepository _projectRepo = ProjectRepository();

  void loadFileList(String projectId) async {
    emit(state.copyWith(status: FileListStatus.loading));
    try {
      final project = await _projectRepo.get(projectId);
      final fileList = await _fileRepo.getFilesLinkedToProject(projectId);
      emit(state.copyWith(
        projectName: project.name,
        status: FileListStatus.success,
        fileList: fileList,
      ));
    } catch (e) {
      emit(state.copyWith(status: FileListStatus.error));
    }
  }
}
