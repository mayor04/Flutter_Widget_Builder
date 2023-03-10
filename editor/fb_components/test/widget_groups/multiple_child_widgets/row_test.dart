import 'package:fb_components/src/widget_groups/multiple_child_widgets/row/fb_row_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/map_extension.dart';

void main() {
  test('Row code formatted correctly', () {
    final formatter = WidgetFormatter();
    final rowConfig = FbRowConfig();

    formatter.formatWidget(rowConfig.generateCode(''));

    rowConfig.updateStyles(
      FbRowStyles('1',
          mainAlignment: MainAxisAlignment.center,
          crossAlignment: CrossAxisAlignment.center,
          axisSize: MainAxisSize.min),
    );

    formatter.formatWidget(
      rowConfig.generateCode(rowConfig.generateCode('')),
    );
  });

  test('Row config serialized correctly', () {
    final rowConfig = FbRowConfig();

    rowConfig.updateStyles(
      FbRowStyles('1',
          mainAlignment: MainAxisAlignment.center,
          crossAlignment: CrossAxisAlignment.center,
          axisSize: MainAxisSize.min),
    );
    final json = rowConfig.toJson().reDecode() as Map<String, dynamic>;
    ;
    final newConfig = FbRowConfig.fromJson(json);

    expect(newConfig.toJson(), json);
  });
}
