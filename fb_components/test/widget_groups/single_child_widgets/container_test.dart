import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Container code formatted without errors', () {
    final formatter = WidgetFormatter();
    final containerConfig = FbContainerConfig();

    formatter.formatWidget(containerConfig.generateCode(null));

    containerConfig.updateStyles(
      FbContainerStyles(
        1,
        color: Colors.blue,
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
      ),
    );

    formatter.formatWidget(
      containerConfig.generateCode(null),
    );
  });

  test('Container config serialized correctly', () {
    final containerConfig = FbContainerConfig();

    containerConfig.updateStyles(
      FbContainerStyles(
        1,
        color: Colors.blue,
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
      ),
    );
    final json = containerConfig.toJson();
    final newConfig = FbContainerConfig.fromJson(json);

    expect(newConfig.toJson(), json);
  });
}
