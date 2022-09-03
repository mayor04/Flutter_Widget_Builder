import 'package:flutter/material.dart';

extension DebugBorder on Widget {
  Widget get debugBorder {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 237, 176, 144))),
      child: this,
    );
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

extension StringExtension on String {
  String get capitalizeFirst {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension KeyRect on BuildContext {
  RenderBox? get renderBox {
    return findRenderObject() as RenderBox?;
  }

  Offset get position {
    return renderBox?.localToGlobal(Offset.zero) ?? const Offset(0, 0);
  }

  double get dy {
    return position.dy;
  }

  double get dx {
    return position.dx;
  }

  Size get widgetSize {
    return renderBox?.hasSize == true ? renderBox!.size : const Size(0, 0);
  }
}
