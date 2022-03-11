import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'styles_input_event.dart';
part 'styles_input_state.dart';

class StylesInputBloc extends Bloc<StylesInputEvent, StylesInputState> {
  StylesInputBloc() : super(StylesInputInitial()) {
    on<StylesInputEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
