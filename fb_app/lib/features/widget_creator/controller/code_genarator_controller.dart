import 'package:dart_style/dart_style.dart';
import 'package:fb_app/features/widget_creator/controller/interface_controller.dart';
import 'package:fb_app/features/widget_creator/models/fb_details.dart';
import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';

/// Generates code the widget that is currently being built
///
/// This is seperated from the `InterfaceController` but depends on it to get all the widget
class CodeGeneratorController {
  const CodeGeneratorController(this._interfaceController);
  final InterfaceController _interfaceController;

  Map<int, FbWidgetDetails> get allDetails => _interfaceController.fbDetailsMap;
  Map<int, BaseFbConfig> get allWidgetConfig => _interfaceController.fbWidgetsMap;

  String getCode() {
    // Get the first details
    // TODO: handle all null errors
    final firstChildId = allDetails[xMainId]!.firstChildId;

    final formatter = DartFormatter();
    final code = _generateCode(firstChildId!, allDetails[firstChildId]!);
    print(code);

    return formatter.format('''
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

  String _generateCode(int id, FbWidgetDetails widgetDetails, {int level = 1}) {
    final children = widgetDetails.children;
    final List<String> childrenCodeList = [];

    for (var childId in children) {
      final details = allDetails[childId];

      if (details != null) {
        final childCode = _generateCode(
          childId,
          details,
          level: level + 1,
        );

        childrenCodeList.add(childCode);
      }
    }

    // Get the config
    final widgetConfig = allWidgetConfig[id]!;
    final childCode = childrenCodeList.isEmpty ? null : childrenCodeList.join('\n');

    return widgetConfig.generateCode(childCode, level);
  }
}
