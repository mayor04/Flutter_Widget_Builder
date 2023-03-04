import 'package:fb_app/features/widget_creator/tabs/params/bloc/global_params_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalParamsWidget extends StatelessWidget {
  const GlobalParamsWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  static GlobalParamsState of(BuildContext context) {
    return BlocProvider.of<GlobalParamsBloc>(context).state;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalParamsBloc(),
      child: child,
    );
  }
}
