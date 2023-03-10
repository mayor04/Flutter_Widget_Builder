import 'package:flutter/material.dart';

class DoubleInputWrap extends StatelessWidget {
  const DoubleInputWrap({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
