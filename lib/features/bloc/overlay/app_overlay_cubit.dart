import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';

part 'app_overlay_state.dart';

class AppOverlayCubit extends Cubit<AppOverlayState> {
  final log = AppLog('NotifierCubit');
  AppOverlayCubit() : super(AppOverlayInitial());

  @override
  void onChange(Change<AppOverlayState> change) {
    super.onChange(change);
    log.out('onChange()', change);
  }

  removeOverlay() {
    emit(RemoveAppOverlay());
  }

  showAddWidgetListOverlay({
    required Offset position,
    required FbWidgetType parentType,
    required int parentId,
  }) {
    emit(AppOverlayAddState(
      position: position,
      parentType: parentType,
      parentId: parentId,
    ));
  }

  showSelectionOverlay({
    required Offset position,
    required Size size,
    required FbWidgetType widgetType,
    required int parentId,
  }) {
    emit(AppOverlaySelection(
      position: position,
      widgetType: widgetType,
      size: size,
      parentId: parentId,
    ));
  }
}
