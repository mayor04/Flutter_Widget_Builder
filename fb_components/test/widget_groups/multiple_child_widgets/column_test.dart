import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/map_extension.dart';

void main() {
  test('Column code formatted correctly', () {
    final formatter = WidgetFormatter();
    final columnConfig = FbColumnConfig();

    formatter.formatWidget(columnConfig.generateCode(''));

    columnConfig.updateStyles(
      FbColumnStyles(1,
          mainAlignment: MainAxisAlignment.center,
          crossAlignment: CrossAxisAlignment.center,
          axisSize: MainAxisSize.min),
    );

    formatter.formatWidget(
      columnConfig.generateCode(columnConfig.generateCode('')),
    );
  });

  // write test for from json to json for column
  test('Column config serialized correctly', () {
    final columnConfig = FbColumnConfig();

    columnConfig.updateStyles(
      FbColumnStyles(1,
          mainAlignment: MainAxisAlignment.center,
          crossAlignment: CrossAxisAlignment.center,
          axisSize: MainAxisSize.min),
    );

    final json = columnConfig.toJson().reDecode() as Map<String, dynamic>;
    final newConfig = FbColumnConfig.fromJson(json);

    expect(newConfig.toJson(), json);
  });
}
