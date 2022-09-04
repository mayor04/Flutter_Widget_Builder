import 'package:bloc/bloc.dart';
import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/widgets.dart';

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

  /// This is the dialog shown when the use
  /// wants to either add or wrap a widget
  showAddWidgetListOverlay({
    required Offset position,
    required FbWidgetType widgetType,
    required int widgetId,
    AddWidgetType addWidgetType = AddWidgetType.add,
  }) {
    emit(AppOverlayAddState(
      position: position,
      widgetType: widgetType,
      widgetId: widgetId,
      addWidgetType: addWidgetType,
    ));
  }

  showMenuOverlay({
    required Offset position,
    required FbWidgetType widgetType,
    required int widgetId,
  }) {
    emit(AppOverlayMenu(
      position: position,
      widgetType: widgetType,
      widgetId: widgetId,
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
