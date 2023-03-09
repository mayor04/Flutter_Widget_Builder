import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_app/utils/enums/state_status_enum.dart';
import 'package:fb_core/fb_core.dart';
import 'package:meta/meta.dart';

part 'app_list_state.dart';

class AppListBloc extends Cubit<AppListState> {
  AppListBloc() : super(const AppListState(projectList: []));

  final AppDetailsRepository _appDetailsRepo = gi<AppDetailsRepository>();

  void loadProjectList() async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      final projectList = await _appDetailsRepo.getAll();
      emit(state.copyWith(
        status: StateStatus.success,
        projectList: projectList,
      ));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error));
    }
  }
}
