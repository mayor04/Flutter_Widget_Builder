part of 'file_list_bloc.dart';

@immutable
class FileListState extends Equatable {
  const FileListState(
      {this.status = FileListStatus.initial, required this.fileList, required this.projectName});

  final String projectName;
  final FileListStatus status;
  final List<FileModel> fileList;

  @override
  List<Object> get props => [status, fileList];

  FileListState copyWith({
    FileListStatus? status,
    List<FileModel>? fileList,
    String? projectName,
  }) {
    return FileListState(
      status: status ?? this.status,
      fileList: fileList ?? this.fileList,
      projectName: projectName ?? this.projectName,
    );
  }
}

enum FileListStatus { initial, loading, success, error }
