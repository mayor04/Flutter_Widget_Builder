import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';

part 'styles_input_event.dart';
part 'styles_input_state.dart';

class StylesInputBloc extends Bloc<StylesInputEvent, StylesInputState> {
  final log = AppLog('StylesInputBloc');
  late final FbInterfaceController _fbController;

  StylesInputBloc(FbInterfaceController fbController)
      : super(const StylesInputState([])) {
    on<StylesGetInputsEvent>(_getStyles);
  }

  Future<void> _getStyles(
    StylesGetInputsEvent event,
    Emitter<StylesInputState> emit,
  ) async {
    try {
      var stylesInput = _fbController.getWidgetInput(event.widgetId);
      emit(StylesInputState(stylesInput));
    } catch (e) {
      log.error('addEvent()', e.toString());
    }
  }
}
