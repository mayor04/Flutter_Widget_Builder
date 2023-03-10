import 'package:fb_widget_editor/src/presentation/widget_creator/controller/interface_controller.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/params/bloc/global_params_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalParamsWidget extends StatelessWidget {
  const GlobalParamsWidget({
    required this.child,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final InterfaceController controller;

  static GlobalParamsState of(BuildContext context) {
    return BlocProvider.of<GlobalParamsBloc>(context).state;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => GlobalParamsBloc(controller),
      child: child,
    );
  }
}
