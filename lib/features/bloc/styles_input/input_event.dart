part of 'input_bloc.dart';

abstract class InputEvent extends Equatable {
  const InputEvent();

  @override
  List<Object> get props => [];
}

class GetInputsEvent extends InputEvent {
  final int widgetId;
  const GetInputsEvent(this.widgetId);
}
