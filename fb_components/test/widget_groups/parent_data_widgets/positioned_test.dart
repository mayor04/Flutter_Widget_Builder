import 'package:fb_components/src/widget_groups/parent_data_widgets/positioned/fb_positioned_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Positioned code formatted without errors', () {
    final formatter = WidgetFormatter();
    final positionedConfig = FbPositionedConfig();

    formatter.formatWidget(positionedConfig.generateCode(''));

    positionedConfig
      ..bottomInput.value = 20
      ..topInput.value = 20
      ..leftInput.value = 10
      ..rightInput.value = 10;

    formatter.formatWidget(
      positionedConfig.generateCode(''),
    );
  });
}
