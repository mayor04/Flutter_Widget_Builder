import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_app/features/widget_creator/controller/interface_controller.dart';
import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';

part 'input_event.dart';
part 'styles_input_state.dart';

class StylesInputBloc extends Cubit<StylesInputState> {
  final log = AppLog('StylesInputBloc');
  late final InterfaceController _fbController;

  StylesInputBloc(InterfaceController fbController) : super(const StylesInputState(null, xMainId)) {
    _fbController = fbController;
  }

  Future<void> getStyles(String widgetId) async {
    try {
      final styles = _fbController.getWidgetStyles(widgetId);
      emit(StylesInputState(styles, widgetId));
    } catch (e) {
      log.error('', e.toString());
    }
  }

  Future<void> changeStyles(BaseFbStyles styles) async {
    try {
      _fbController.changeWidgetStyles(styles);
      emit(StylesInputState(styles, styles.id));
    } catch (e) {
      log.error('addEvent()', e.toString());
    }
  }
}
