part of 'styles_input_bloc.dart';

class StylesInputState extends Equatable {
  final List<FbInputBase> allInput;
  const StylesInputState(this.allInput);

  @override
  List<Object> get props => allInput;
}
