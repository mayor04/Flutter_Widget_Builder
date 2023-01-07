import 'package:fb_components/src/widget_groups/single_child_widgets/sized_box/fb_sized_box_config.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SizedBox code formatted without errors', () {
    final formatter = WidgetFormatter();
    final boxConfig = FbSizedBoxConfig();

    formatter.formatWidget(boxConfig.generateCode(null));

    boxConfig.updateStyles(
      FbSizedBoxStyles(1, height: 20, width: 20),
    );

    formatter.formatWidget(
      boxConfig.generateCode(''),
    );
  });

  test('SizedBox config serialized correctly', () {
    final boxConfig = FbSizedBoxConfig();

    boxConfig.updateStyles(
      FbSizedBoxStyles(1, height: 20, width: 20),
    );
    final json = boxConfig.toJson();
    final newConfig = FbSizedBoxConfig.fromJson(json);

    expect(newConfig.toJson(), json);
  });
}
