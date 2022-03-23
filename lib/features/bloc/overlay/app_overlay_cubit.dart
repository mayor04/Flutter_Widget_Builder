import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';

part 'app_overlay_state.dart';

class AppOverlayCubit extends Cubit<AppOverlayState> {
  AppOverlayCubit() : super(AppOverlayInitial());

  showAddWidgetListOverlay({
    required Offset position,
    required FbWidgetType parentType,
  }) {
    emit(AppOverlayAddState(
      position: position,
      parentType: parentType,
    ));
  }

  removeOverlay() {
    emit(RemoveAppOverlay());
  }
}
