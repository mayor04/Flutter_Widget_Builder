import 'package:fb_core/fb_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // late FbColumnConfig
  // setUp(() {

  // });

  test('Column formatter test', () {
    final formatter = WidgetFormatter();
    formatter.formatWidget('Container()');
  });
}
