import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';

part 'app_overlay_state.dart';

class AppOverlayCubit extends Cubit<AppOverlayState> {
  AppOverlayCubit() : super(AppOverlayInitial());

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

  removeOverlay() {
    emit(RemoveAppOverlay());
  }
}
