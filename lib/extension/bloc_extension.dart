import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/features/bloc/styles_input/input_bloc.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';

extension Blocs on BuildContext {
  InputBloc get inputBloc {
    return BlocProvider.of<InputBloc>(this);
  }

  WidgetTreeBloc get widgetTreeBloc {
    return BlocProvider.of<WidgetTreeBloc>(this);
  }
}
