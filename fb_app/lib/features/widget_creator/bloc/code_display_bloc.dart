import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_app/features/widget_creator/controller/code_genarator_controller.dart';
import 'package:fb_core/fb_core.dart';

part 'code_display_state.dart';

class CodeDisplayBloc extends Cubit<CodeDisplayState> {
  final log = AppLog('CodeDisplayBloc');

  CodeDisplayBloc({required this.generator}) : super(const CodeDisplayState(''));

  final CodeGeneratorController generator;

  void generateCode() {
    try {
      emit(CodeDisplayState(generator.getCode()));
    } catch (e) {
      log.error('', e.toString());

      emit(const CodeDisplayState('Unable to generate Code'));
    }
  }
}
