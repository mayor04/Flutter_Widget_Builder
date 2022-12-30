import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_core/fb_core.dart';
import 'package:meta/meta.dart';

part 'project_state.dart';

class ProjectBloc extends Cubit<ProjectState> {
  ProjectBloc() : super(const ProjectState(status: ProjectStateStatus.initial));

  final ProjectRepository _projectRepo = ProjectRepository();

  void createProject({
    required String name,
    String? desc,
  }) async {
    emit(state.copyWith(status: ProjectStateStatus.loading));
    try {
      await _projectRepo.create(ProjectModel(
        id: IdGen.generateIdString(),
        name: name,
        desc: desc ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      emit(state.copyWith(status: ProjectStateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ProjectStateStatus.error));
    }
  }

  void updateProject(ProjectModel project) async {
    emit(state.copyWith(status: ProjectStateStatus.loading));
    try {
      await _projectRepo.update(project);
      emit(state.copyWith(status: ProjectStateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ProjectStateStatus.error));
    }
  }

  void deleteProject() async {
    emit(state.copyWith(status: ProjectStateStatus.loading));
    try {
      await _projectRepo.delete();
      emit(state.copyWith(status: ProjectStateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ProjectStateStatus.error));
    }
  }
}
