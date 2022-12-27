import 'package:dart_style/dart_style.dart';

class WidgetFormatter {
  final _formatter = DartFormatter();

  formatWidget(String code) {
    return _formatter.format('''
        class WidgetName extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
            return SizedBox(
              child: $code
            );
          }
        }
    ''');
  }
}
