import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_app/utils/enums/state_status_enum.dart';
import 'package:fb_core/fb_core.dart';
import 'package:meta/meta.dart';

part 'widget_list_state.dart';

class WidgetListBloc extends Cubit<WidgetListState> {
  WidgetListBloc() : super(const WidgetListState(fileList: [], projectName: ''));

  final WidgetDetailsRepository _widgetRepo = gi<WidgetDetailsRepository>();
  final AppDetailsRepository _appRepo = gi<AppDetailsRepository>();

  void loadWidgetList(String? applicationId) async {
    emit(state.copyWith(status: StateStatus.loading));
    if (applicationId == null) {
      emit(state.copyWith(
        status: StateStatus.error,
        errorMessage: 'Project ID is null',
      ));
      return;
    }

    try {
      final project = await _appRepo.get(applicationId);
      final fileList = await _widgetRepo.getFilesLinkedToProject(applicationId);
      emit(state.copyWith(
        appName: project.name,
        status: StateStatus.success,
        fileList: fileList,
      ));
    } catch (e, trace) {
      log(e.toString());
      log(trace.toString());
      emit(state.copyWith(status: StateStatus.error));
    }
  }
}
