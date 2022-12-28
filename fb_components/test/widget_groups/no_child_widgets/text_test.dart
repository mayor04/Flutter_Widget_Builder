import 'package:fb_components/src/widget_groups/no_child_widgets/text/fb_text_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final WidgetFormatter formatter;

  setUp(() {
    formatter = WidgetFormatter();
  });

  group('Text Formatting', () {
    test('Text code formatted correctly', () {
      final textConfig = FbTextConfig();

      textConfig
        ..textInput.value = 'Normal text'
        ..fontSizeInput.value = 19
        ..fontWeightInput.value = 'w300';

      formatter.formatWidget(
        textConfig.generateCode(''),
      );
    });

    test('Text formatting with bad text', () {
      final textConfig = FbTextConfig();

      textConfig.textInput.value = '''Abnormal '"text''';

      formatter.formatWidget(
        textConfig.generateCode(''),
      );
    });
  });
}
