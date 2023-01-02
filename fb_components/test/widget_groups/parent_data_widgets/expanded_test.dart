import 'package:fb_components/src/widget_groups/parent_data_widgets/expanded/fb_expanded_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Expanded code formatted without errors', () {
    final formatter = WidgetFormatter();
    final expandedConfig = FbExpandedConfig();

    expandedConfig.flexInput.value = 2;
    formatter.formatWidget(expandedConfig.generateCode(''));

    formatter.formatWidget(
      expandedConfig.generateCode(''),
    );
  });
}
