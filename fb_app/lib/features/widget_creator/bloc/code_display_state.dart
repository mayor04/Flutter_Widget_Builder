part of 'code_display_bloc.dart';

class CodeDisplayState extends Equatable {
  const CodeDisplayState(this.generatedCode);
  final String generatedCode;

  @override
  List<Object> get props => [generatedCode];
}
