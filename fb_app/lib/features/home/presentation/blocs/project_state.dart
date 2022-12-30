part of 'project_bloc.dart';

@immutable
class ProjectState extends Equatable {
  const ProjectState({
    this.status = ProjectStateStatus.initial,
  });

  final ProjectStateStatus status;

  @override
  List<Object> get props => [status];

  // copy with
  ProjectState copyWith({
    ProjectStateStatus? status,
    List<ProjectModel>? projectList,
  }) {
    return ProjectState(
      status: status ?? this.status,
    );
  }
}

enum ProjectStateStatus { initial, loading, success, error }
