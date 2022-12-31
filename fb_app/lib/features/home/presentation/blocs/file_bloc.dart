import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_core/fb_core.dart';
import 'package:meta/meta.dart';

part 'file_state.dart';

class FileBloc extends Cubit<FileState> {
  FileBloc() : super(const FileState(status: FileStateStatus.initial));

  final FilesRepository _fileRepo = FilesRepository();

  void createFile({
    required String name,
    required String projectId,
    String? desc,
  }) async {
    emit(state.copyWith(status: FileStateStatus.loading));
    try {
      await _fileRepo.create(FileModel(
        id: IdGen.generateIdString(),
        name: name,
        desc: desc ?? '',
        projectId: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      emit(state.copyWith(status: FileStateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FileStateStatus.error));
    }
  }

  void updateFile(FileModel file) async {
    emit(state.copyWith(status: FileStateStatus.loading));
    try {
      await _fileRepo.update(file);
      emit(state.copyWith(status: FileStateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FileStateStatus.error));
    }
  }

  void deleteFile() async {
    emit(state.copyWith(status: FileStateStatus.loading));
    try {
      await _fileRepo.delete();
      emit(state.copyWith(status: FileStateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FileStateStatus.error));
    }
  }
}
