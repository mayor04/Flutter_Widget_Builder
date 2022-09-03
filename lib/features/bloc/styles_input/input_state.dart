part of 'input_bloc.dart';

class InputState extends Equatable {
  final int widgetId;
  final List<BaseFbInput> allInput;
  const InputState(this.allInput, this.widgetId);

  @override
  List<Object> get props => allInput;
}
