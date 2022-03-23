import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/features/bloc/styles_input/input_bloc.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';

extension DebugBorder on Widget {
  Widget get debugBorder {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 237, 176, 144))),
      child: this,
    );
  }
}

extension SafeList<T> on List<T> {
  ///Returns null when the element at the index
  ///is not present
  T? itemAt(int index) {
    if (index >= length) {
      return null;
    }
    return this[index];
  }
}

extension Theming on BuildContext {
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }
}

extension MediaQueryExt on BuildContext {
  double get screenHeight {
    return MediaQuery.of(this).size.height;
  }

  double get screenWidth {
    return MediaQuery.of(this).size.width;
  }
}

extension Blocs on BuildContext {
  InputBloc get inputBloc {
    return BlocProvider.of<InputBloc>(this);
  }

  WidgetTreeBloc get widgetTreeBloc {
    return BlocProvider.of<WidgetTreeBloc>(this);
  }
}

extension StringExtension on String {
  String get capitalizeFirst {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
