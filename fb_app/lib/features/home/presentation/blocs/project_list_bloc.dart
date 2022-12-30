import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_core/fb_core.dart';
import 'package:meta/meta.dart';

part 'project_list_state.dart';

class ProjectListBloc extends Cubit<ProjectListState> {
  ProjectListBloc() : super(const ProjectListState(projectList: []));

  final ProjectRepository _projectRepo = ProjectRepository();

  void loadProjectList() async {
    emit(state.copyWith(status: ProjectListStatus.loading));
    try {
      final projectList = await _projectRepo.getAll();
      emit(state.copyWith(
        status: ProjectListStatus.success,
        projectList: projectList,
      ));
    } catch (e) {
      emit(state.copyWith(status: ProjectListStatus.error));
    }
  }
}
