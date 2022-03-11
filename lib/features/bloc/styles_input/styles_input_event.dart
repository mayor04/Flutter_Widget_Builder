part of 'styles_input_bloc.dart';

abstract class StylesInputEvent extends Equatable {
  const StylesInputEvent();

  @override
  List<Object> get props => [];
}

class StylesGetInputsEvent extends StylesInputEvent {
  final int widgetId;
  const StylesGetInputsEvent(this.widgetId);
}
