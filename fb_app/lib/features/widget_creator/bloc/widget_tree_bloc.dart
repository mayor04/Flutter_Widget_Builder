import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_app/features/widget_creator/controller/interface_controller.dart';
import 'package:fb_app/features/widget_creator/models/fb_details.dart';
import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';

part 'widget_tree_event.dart';
part 'widget_tree_state.dart';

/// Widget tree is the list of widget on the left side
/// it handles adding and removing of the widgets
class WidgetTreeBloc extends Bloc<WidgetTreeEvent, WidgetTreeState> {
  final log = AppLog('WidgetTreeBloc');
  late final InterfaceController _fbController;

  WidgetTreeBloc(InterfaceController fbController)
      : super(WidgetTreeState(fbDetailsMap: {}, fbConfigMap: {})) {
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
    await _fbController.ensureInitialized();
    var fbDataMap = _fbController.fbDetailsMap;
    emit(WidgetTreeState(
      fbConfigMap: _fbController.fbConfigMap,
      fbDetailsMap: fbDataMap,
      action: WidgetTreeAction.add,
    ));
  }

  // Add event is triggered when user decides to add a widget as a child
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
          fbConfigMap: _fbController.fbConfigMap,
          action: WidgetTreeAction.add,
          widgetId: widgetConfig.id,
          parentId: event.parentId));
    } catch (e) {
      log.error('addEvent()', e.toString());
    }
  }

  // Wrap event is triggered when user selects wrap with
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
        fbConfigMap: _fbController.fbConfigMap,
        action: WidgetTreeAction.wrap,
        widgetId: widgetConfig.id,
      ));
    } catch (e) {
      log.error('wrapEvent()', e.toString());
    }
  }

  // Remove event will remove only the particular widget and not the children
  Future<void> _removeEvent(
    RemoveWidgetEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {
    try {
      var fbDataMap = _fbController.removeWidget(event.id);

      emit(WidgetTreeState(
        fbDetailsMap: fbDataMap,
        fbConfigMap: _fbController.fbConfigMap,
        action: WidgetTreeAction.remove,
        widgetId: event.id,
      ));
    } catch (e) {
      log.error('wrapEvent()', e.toString());
    }
  }

  // Delete events permanently deletes this widget and all the children
  Future<void> _deleteEvent(
    DeleteWidgetEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {
    try {
      var fbDataMap = _fbController.deleteWidget(event.id);

      emit(WidgetTreeState(
        fbDetailsMap: fbDataMap,
        fbConfigMap: _fbController.fbConfigMap,
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
