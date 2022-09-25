import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_widget_builder/features/widget_creator/controller/code_genarator_controller.dart';

part 'code_display_state.dart';

class CodeDisplayBloc extends Cubit<CodeDisplayState> {
  CodeDisplayBloc({required this.generator}) : super(const CodeDisplayState(''));

  final CodeGeneratorController generator;

  void generateCode() {
    try {
      emit(CodeDisplayState(generator.getCode()));
    } catch (e, trace) {
      print(trace);

      emit(const CodeDisplayState('Unable to generate Code'));
    }
  }
}
