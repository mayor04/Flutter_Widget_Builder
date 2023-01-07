import 'package:fb_components/src/widget_groups/multiple_child_widgets/stack/fb_stack_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/map_extension.dart';

void main() {
  test('Stack code formatted correctly', () {
    final formatter = WidgetFormatter();
    final stackConfig = FbStackConfig();

    formatter.formatWidget(stackConfig.generateCode(''));
    stackConfig.updateStyles(
      FbStackStyles(
        1,
        stackFit: StackFit.loose,
      ),
    );

    formatter.formatWidget(
      stackConfig.generateCode(stackConfig.generateCode('')),
    );
  });

  test('Stack config serialized correctly', () {
    final stackConfig = FbStackConfig();

    stackConfig.updateStyles(
      FbStackStyles(
        1,
        stackFit: StackFit.loose,
      ),
    );
    final json = stackConfig.toJson().reDecode() as Map<String, dynamic>;
    final newConfig = FbStackConfig.fromJson(json);

    expect(newConfig.toJson(), json);
  });
}
