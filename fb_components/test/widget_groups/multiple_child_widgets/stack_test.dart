import 'package:fb_components/src/widget_groups/multiple_child_widgets/stack/fb_stack_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Stack code formatted correctly', () {
    final formatter = WidgetFormatter();
    final stackConfig = FbStackConfig();

    formatter.formatWidget(stackConfig.generateCode(''));
    stackConfig.fitInput.value = StackFit.expand;

    formatter.formatWidget(
      stackConfig.generateCode(stackConfig.generateCode('')),
    );
  });
}
