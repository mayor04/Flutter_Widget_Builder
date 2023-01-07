part of 'styles_input_bloc.dart';

abstract class InputEvent extends Equatable {
  const InputEvent();

  @override
  List<Object> get props => [];
}

class GetInputsEvent extends InputEvent {
  final String widgetId;
  const GetInputsEvent(this.widgetId);
}
