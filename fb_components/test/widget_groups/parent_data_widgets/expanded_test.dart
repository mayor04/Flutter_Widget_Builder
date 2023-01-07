import 'package:fb_components/src/widget_groups/parent_data_widgets/expanded/fb_expanded_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Expanded code formatted without errors', () {
    final formatter = WidgetFormatter();
    final expandedConfig = FbExpandedConfig(
      styles: FbExpandedStyles(
        '1',
        flex: 10,
      ),
    );

    formatter.formatWidget(expandedConfig.generateCode(null));

    formatter.formatWidget(
      expandedConfig.generateCode(null),
    );
  });

  test('Expanded config serialized correctly', () {
    final expandedConfig = FbExpandedConfig(
      styles: FbExpandedStyles(
        '1',
        flex: 0,
      ),
    );

    final json = expandedConfig.toJson();
    final newConfig = FbExpandedConfig.fromJson(json);

    expect(newConfig.toJson(), json);
  });
}
