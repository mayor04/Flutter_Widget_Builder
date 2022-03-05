import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final double? vertical;
  final double? horizontal;

  const Box.vertical(
    this.vertical, {
    Key? key,
    this.horizontal,
  }) : super(key: key);

  const Box.horizontal(
    this.horizontal, {
    Key? key,
    this.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: vertical,
      width: horizontal,
    );
  }
}
