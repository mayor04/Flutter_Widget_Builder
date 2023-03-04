part of 'global_params_bloc.dart';

class GlobalParamsState extends Equatable {
  GlobalParamsState(Map<String, InputParams>? parameters)
      : parameters = parameters ?? <String, InputParams>{};

  final Map<String, InputParams> parameters;

  @override
  List<Object?> get props => [parameters.values.map((e) => e.id)];
}
