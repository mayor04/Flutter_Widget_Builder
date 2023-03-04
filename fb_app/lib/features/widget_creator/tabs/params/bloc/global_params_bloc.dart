import 'package:equatable/equatable.dart';
import 'package:fb_components/fb_components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_params_state.dart';

class GlobalParamsBloc extends Cubit<GlobalParamsState> {
  GlobalParamsBloc() : super(GlobalParamsState(null));

  void addParam(InputParams param) {
    final params = state.parameters;
    params[param.id] = param;
    emit(GlobalParamsState(params));
  }

  void updateParam(String key, InputParams param) {
    final params = state.parameters;
    params[key] = param;
    emit(GlobalParamsState(params));
  }

  void removeParam(String key) {
    final params = state.parameters;
    params.remove(key);
    emit(GlobalParamsState(params));
  }

  @override
  Future<void> close() {
    print('is closing params bloc');
    return super.close();
  }
}
