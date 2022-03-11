import 'package:flutter/material.dart';

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

extension StringExtension on String {
  String get capitalizeFirst {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
