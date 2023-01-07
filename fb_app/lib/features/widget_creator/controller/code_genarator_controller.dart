import 'package:fb_app/features/widget_creator/controller/interface_controller.dart';
import 'package:fb_app/features/widget_creator/models/fb_details.dart';
import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';

/// Generates code the widget that is currently being built
///
/// This is seperated from the `InterfaceController` but depends on it to get all the widget
class CodeGeneratorController {
  CodeGeneratorController(this._interfaceController);
  final InterfaceController _interfaceController;
  final WidgetFormatter widgetFormatter = WidgetFormatter();

  Map<String, FbWidgetDetails> get allDetails => _interfaceController.fbDetailsMap;
  Map<String, BaseFbConfig> get allWidgetConfig => _interfaceController.fbConfigMap;

  String getCode() {
    // Get the first details
    // TODO: handle all null errors
    final firstChildId = allDetails[xMainId]!.firstChildId;
    final code = _generateCode(firstChildId!, allDetails[firstChildId]!);
    print(code);

    return widgetFormatter.formatWidget(code);
  }

  String _generateCode(String id, FbWidgetDetails widgetDetails, {int level = 1}) {
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

    return widgetConfig.generateCode(childCode);
  }
}
