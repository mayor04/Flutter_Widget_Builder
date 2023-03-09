part of 'global_params_bloc.dart';

class GlobalParamsState extends Equatable {
  GlobalParamsState(GlobalParamsMap? parameters)
      : parameters = parameters ?? <String, InputParams>{};

  final GlobalParamsMap parameters;

  @override
  List<Object?> get props => [parameters.values.map((e) => e.id)];
}
