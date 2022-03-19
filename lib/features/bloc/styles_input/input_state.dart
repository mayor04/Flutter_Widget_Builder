part of 'styles_input_bloc.dart';

class InputState extends Equatable {
  final List<FbInputBase> allInput;
  const InputState(this.allInput);

  @override
  List<Object> get props => allInput;
}
