import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_details.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

part 'widget_tree_event.dart';
part 'widget_tree_state.dart';

class WidgetTreeBloc extends Bloc<WidgetTreeEvent, WidgetTreeState> {
  final log = AppLog('WidgetTreeBloc');
  late final FbInterfaceController _fbController;

  WidgetTreeBloc(FbInterfaceController fbController) : super(WidgetTreeState(fbDetailsMap: {})) {
    _fbController = fbController;

    on<InitialWidgetTreeEvent>(_initialEvent);
    on<AddWidgetEvent>(_addEvent);
    on<RemoveWidgetEvent>(_removeEvent);
    on<WrapWidgetEvent>(_wrapEvent);
    on<DeleteWidgetEvent>(_deleteEvent);
  }

  Future<void> _initialEvent(
    InitialWidgetTreeEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {
    var fbDataMap = _fbController.initialLoad();
    emit(WidgetTreeState(
      fbDetailsMap: fbDataMap,
      action: WidgetTreeAction.add,
    ));
  }

  Future<void> _addEvent(
    AddWidgetEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {
    try {
      var fbDataMap = _fbController.addChildWidget(
        event.parentId,
        event.fbWidget,
      );

      emit(WidgetTreeState(
          fbDetailsMap: fbDataMap,
          action: WidgetTreeAction.add,
          widgetId: event.fbWidget.id,
          parentId: event.parentId));
    } catch (e) {
      log.error('addEvent()', e.toString());
    }
  }

  Future<void> _wrapEvent(
    WrapWidgetEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {
    try {
      var fbDataMap = _fbController.wrapWidget(
        event.childId,
        event.fbWidget,
      );

      emit(WidgetTreeState(
        fbDetailsMap: fbDataMap,
        action: WidgetTreeAction.wrap,
        widgetId: event.fbWidget.id,
      ));
    } catch (e) {
      log.error('wrapEvent()', e.toString());
    }
  }

  Future<void> _removeEvent(
    RemoveWidgetEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {
    try {
      var fbDataMap = _fbController.removeWidget(event.id);

      emit(WidgetTreeState(
        fbDetailsMap: fbDataMap,
        action: WidgetTreeAction.remove,
        widgetId: event.id,
      ));
    } catch (e) {
      log.error('wrapEvent()', e.toString());
    }
  }

  Future<void> _deleteEvent(
    DeleteWidgetEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {
    try {
      var fbDataMap = _fbController.deleteWidget(event.id);

      emit(WidgetTreeState(
        fbDetailsMap: fbDataMap,
        action: WidgetTreeAction.delete,
        widgetId: event.id,
      ));
    } catch (e) {
      log.error('wrapEvent()', e.toString());
    }
  }

  @override
  void onTransition(Transition<WidgetTreeEvent, WidgetTreeState> transition) {
    super.onTransition(transition);
    log.out('onTransition()', transition.event);
  }
}
