part of 'app_list_bloc.dart';

@immutable
class AppListState extends Equatable {
  const AppListState({
    this.status = StateStatus.initial,
    required this.projectList,
  });

  final StateStatus status;
  final List<AppDetailsModel> projectList;

  @override
  List<Object> get props => [status, projectList];

  // copy with
  AppListState copyWith({
    StateStatus? status,
    List<AppDetailsModel>? projectList,
  }) {
    return AppListState(
      status: status ?? this.status,
      projectList: projectList ?? this.projectList,
    );
  }
}
