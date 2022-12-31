part of 'file_bloc.dart';

@immutable
class FileState extends Equatable {
  const FileState({
    this.status = FileStateStatus.initial,
  });

  final FileStateStatus status;

  @override
  List<Object> get props => [status];

  // copy with
  FileState copyWith({
    FileStateStatus? status,
    List<FileModel>? fileList,
  }) {
    return FileState(
      status: status ?? this.status,
    );
  }
}

enum FileStateStatus { initial, loading, success, error }
