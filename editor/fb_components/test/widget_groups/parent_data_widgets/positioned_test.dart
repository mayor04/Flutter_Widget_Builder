import 'package:fb_components/src/widget_groups/parent_data_widgets/positioned/fb_positioned_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Positioned code formatted without errors', () {
    final formatter = WidgetFormatter();
    final positionedConfig = FbPositionedConfig();

    formatter.formatWidget(positionedConfig.generateCode(null));

    positionedConfig.updateStyles(
      FbPositionedStyles('1', bottom: 20, top: 20, left: 10, right: 10),
    );

    formatter.formatWidget(
      positionedConfig.generateCode(null),
    );
  });

  test('Positioned config serialized correctly', () {
    final positionedConfig = FbPositionedConfig();

    positionedConfig.updateStyles(
      FbPositionedStyles('1', bottom: 20, top: 20, left: 10, right: 10),
    );
    final json = positionedConfig.toJson();
    final newConfig = FbPositionedConfig.fromJson(json);

    expect(newConfig.toJson(), json);
  });
}
