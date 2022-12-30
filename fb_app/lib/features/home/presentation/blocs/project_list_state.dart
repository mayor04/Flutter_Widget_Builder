part of 'project_list_bloc.dart';

@immutable
class ProjectListState extends Equatable {
  const ProjectListState({
    this.status = ProjectListStatus.initial,
    required this.projectList,
  });

  final ProjectListStatus status;
  final List<ProjectModel> projectList;

  @override
  List<Object> get props => [status, projectList];

  // copy with
  ProjectListState copyWith({
    ProjectListStatus? status,
    List<ProjectModel>? projectList,
  }) {
    return ProjectListState(
      status: status ?? this.status,
      projectList: projectList ?? this.projectList,
    );
  }
}

enum ProjectListStatus { initial, loading, success, error }
