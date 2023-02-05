import 'package:fb_components/src/widget_groups/no_child_widgets/text/fb_text_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late WidgetFormatter formatter;

  setUp(() {
    formatter = WidgetFormatter();
  });

  group('Text Formatting', () {
    test('Text code formatted correctly', () {
      final textConfig = FbTextConfig(
        styles: FbTextStyles(
          '1',
          text: 'Hello World',
          color: Colors.red,
        ),
      );

      formatter.formatWidget(
        textConfig.generateCode(''),
      );
    });

    test('Text formatting with bad text', () {
      final textConfig = FbTextConfig(
        styles: FbTextStyles(
          '1',
          text: '''Abnormal '"text''',
          color: Colors.blue,
        ),
      );

      formatter.formatWidget(
        textConfig.generateCode(''),
      );
    });
  });

  test('Text config serialized correctly', () {
    final textConfig = FbTextConfig(
      styles: FbTextStyles(
        '1',
        text: 'Hello World',
        color: Colors.red,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );

    final json = textConfig.toJson();
    final newConfig = FbTextConfig.fromJson(json);

    expect(newConfig.toJson(), json);
  });
}
