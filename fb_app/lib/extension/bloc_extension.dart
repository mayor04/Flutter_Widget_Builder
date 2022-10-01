import 'package:fb_app/features/widget_creator/bloc/input_bloc.dart';
import 'package:fb_app/features/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension Blocs on BuildContext {
  InputBloc get inputBloc {
    return BlocProvider.of<InputBloc>(this);
  }

  WidgetTreeBloc get widgetTreeBloc {
    return BlocProvider.of<WidgetTreeBloc>(this);
  }
}
