import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_app/utils/enums/state_status_enum.dart';
import 'package:fb_core/fb_core.dart';
import 'package:meta/meta.dart';

part 'app_details_state.dart';

class AppDetailsBloc extends Cubit<AppDetailsState> {
  AppDetailsBloc() : super(const AppDetailsState(status: StateStatus.initial));

  final AppDetailsRepository _appDetailsRepo = AppDetailsRepository();

  void createProject({
    required String name,
    String? desc,
  }) async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      await _appDetailsRepo.create(AppDetailsModel(
        id: IdGen.generateIdString(),
        name: name,
        desc: desc ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error));
    }
  }

  void updateProject(AppDetailsModel project) async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      await _appDetailsRepo.update(project);
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error));
    }
  }

  void deleteProject(String id) async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      await _appDetailsRepo.delete(id);
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error));
    }
  }
}
