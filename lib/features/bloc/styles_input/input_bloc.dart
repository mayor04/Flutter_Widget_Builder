import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';

part 'input_event.dart';
part 'input_state.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  final log = AppLog('StylesInputBloc');
  late final FbInterfaceController _fbController;

  InputBloc(FbInterfaceController fbController) : super(const InputState([], xMainId)) {
    _fbController = fbController;

    on<GetInputsEvent>(_getStyles);
  }

  Future<void> _getStyles(
    GetInputsEvent event,
    Emitter<InputState> emit,
  ) async {
    try {
      var stylesInput = _fbController.getWidgetInput(event.widgetId);
      emit(InputState(stylesInput, event.widgetId));
    } catch (e) {
      log.error('addEvent()', e.toString());
    }
  }
}
