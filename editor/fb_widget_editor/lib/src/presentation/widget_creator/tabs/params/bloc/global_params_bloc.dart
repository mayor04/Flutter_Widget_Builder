import 'package:equatable/equatable.dart';
import 'package:fb_components/fb_components.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/controller/interface_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_params_state.dart';

class GlobalParamsBloc extends Cubit<GlobalParamsState> {
  final InterfaceController _interfaceController;

  GlobalParamsBloc(InterfaceController fbController)
      : _interfaceController = fbController,
        super(GlobalParamsState(null)) {
    _initialLoad();
  }

  void _initialLoad() async {
    await _interfaceController.ensureInitialized();
    emit(GlobalParamsState({..._interfaceController.parameters}));
  }

  void addParam(InputParams param) {
    final params = state.parameters;
    params[param.id] = param;

    _interfaceController.setParams(params);
    emit(GlobalParamsState(params));
  }

  void updateParam(String key, InputParams param) {
    final params = state.parameters;
    params[key] = param;

    _interfaceController.setParams(params);
    emit(GlobalParamsState(params));
  }

  void removeParam(String key) {
    final params = state.parameters;
    params.remove(key);

    _interfaceController.setParams(params);
    emit(GlobalParamsState(params));
  }

  @override
  Future<void> close() {
    print('is closing params bloc');
    return super.close();
  }
}
