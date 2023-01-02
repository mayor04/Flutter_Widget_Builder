import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Container code formatted without errors', () {
    final formatter = WidgetFormatter();
    final containerConfig = FbContainerConfig();

    formatter.formatWidget(containerConfig.generateCode(''));
    containerConfig.config
      ..colorInput.value = Colors.blue.value
      ..heightInput.value = 100
      ..widthInput.value = 100
      ..paddingInput.value = [10, 10, 10, 10]
      ..marginInput.value = [10, 10, 10, 10]
      ..alignInput.value = FbContainerStyles.alignmentMap.keys.first;

    final borderInput = containerConfig.config.borderInput;
    (borderInput.inputAt(0) as FbGroupDoubleInputs).input1.value = 10;
    (borderInput.inputAt(0) as FbGroupDoubleInputs).input1.value = 10;

    formatter.formatWidget(
      containerConfig.generateCode(''),
    );
  });
}
