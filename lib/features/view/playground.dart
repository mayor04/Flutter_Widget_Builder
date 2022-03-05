import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';

///This is where all widget appearance are being tested
class Playground extends StatelessWidget {
  const Playground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  decoration: LightBorderDecoration(),
                ),
                Container(
                  height: 50,
                  width: 100,
                  decoration: DarkBorderDecoration(),
                ),
                const SizedBox(
                  height: 30,
                  width: 100,
                  child: TextField(),
                ),
                const SizedBox(
                  height: 30,
                  width: 100,
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
