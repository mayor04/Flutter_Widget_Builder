import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/utils/enum/state_status_enum.dart';
import 'package:meta/meta.dart';

part 'widget_details_state.dart';

class WidgetDetailsBloc extends Cubit<WidgetDetailsState> {
  WidgetDetailsBloc() : super(const WidgetDetailsState(status: StateStatus.initial));

  final WidgetDetailsRepository _fileRepo = gi<WidgetDetailsRepository>();
  final WidgetUIRepository _widgetRepo = gi<WidgetUIRepository>();

  void createFile({
    required String name,
    required String projectId,
    String? desc,
  }) async {
    emit(state.copyWith(status: StateStatus.loading));
    final fileId = IdGen.generateIdString();
    try {
      await _fileRepo.create(WidgetDetailsModel(
        id: fileId,
        name: name,
        desc: desc ?? '',
        projectId: projectId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      await _widgetRepo.create(WidgetUIModel(
        id: fileId,
        idList: [],
        fbConfigMap: {},
        fbDetailsMap: {},
        parameters: {},
      ));

      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error));
    }
  }

  void updateFile(WidgetDetailsModel file) async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      await _fileRepo.update(file);
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error));
    }
  }

  void deleteFile(String id) async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      await _fileRepo.delete(id);
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error));
    }
  }
}
