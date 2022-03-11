import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_widget_builder/core/constant/constant.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_data.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_widget.dart';

part 'widget_tree_event.dart';
part 'widget_tree_state.dart';

class WidgetTreeBloc extends Bloc<WidgetTreeEvent, WidgetTreeState> {
  final log = AppLog('WidgetTreeBloc');
  late final FbInterfaceController _fbController;

  WidgetTreeBloc(FbInterfaceController fbController)
      : super(const WidgetTreeState({})) {
    _fbController = fbController;

    on<InitialWidgetTreeEvent>(_initialEvent);
    on<AddWidgetEvent>(_addEvent);
    on<RemoveWidgetEvent>(_removeEvent);
    on<WrapWidgetEvent>(_wrapEvent);
  }

  Future<void> _initialEvent(
    InitialWidgetTreeEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {
    var fbDataMap = _fbController.initialLoad();
    emit(WidgetTreeState(fbDataMap));
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

      emit(WidgetTreeState(fbDataMap));
    } catch (e) {
      log.error('addEvent()', e.toString());
    }
  }

  Future<void> _removeEvent(
    RemoveWidgetEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {}

  Future<void> _wrapEvent(
    WrapWidgetEvent event,
    Emitter<WidgetTreeState> emit,
  ) async {}

  @override
  void onTransition(Transition<WidgetTreeEvent, WidgetTreeState> transition) {
    super.onTransition(transition);
    log.out('onTransition()', transition.event);
  }
}
