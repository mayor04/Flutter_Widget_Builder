import 'package:flutter/material.dart';

class SectionDisplay extends StatelessWidget {
  const SectionDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 300,
        width: 300,
        color: Colors.white,
      ),
    );
  }
}
