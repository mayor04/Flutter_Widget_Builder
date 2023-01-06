import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Container code formatted without errors', () {
    final formatter = WidgetFormatter();
    final containerConfig = FbContainerConfig();

    formatter.formatWidget(containerConfig.generateCode(''));

    containerConfig.updateStyles(
      FbContainerStyles(
        1,
        color: Colors.blue,
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        colorValue: 0,
      ),
    );

    formatter.formatWidget(
      containerConfig.generateCode(''),
    );
  });
}
