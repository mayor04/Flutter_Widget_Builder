import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_widget_builder/features/controller/fb_details.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';

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
      final widgetConfig = FbConfigFactory.createConfig(event.fbWidgetType);
      var fbDataMap = _fbController.addChildWidget(
        event.parentId,
        widgetConfig,
      );

      emit(WidgetTreeState(
          fbDetailsMap: fbDataMap,
          action: WidgetTreeAction.add,
          widgetId: widgetConfig.id,
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
      final widgetConfig = FbConfigFactory.createConfig(event.fbWidgetType);
      var fbDataMap = _fbController.wrapWidget(
        event.childId,
        widgetConfig,
      );

      emit(WidgetTreeState(
        fbDetailsMap: fbDataMap,
        action: WidgetTreeAction.wrap,
        widgetId: widgetConfig.id,
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
