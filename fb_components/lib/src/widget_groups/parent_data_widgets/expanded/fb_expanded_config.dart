import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/expanded_input.dart';

class FbExpandedConfig extends BaseFbConfig<FbExpandedStyles> with CodeGeneratorLogic {
  var flexInput = FbInputDataExpanded<int>('Flex', 1);

  FbExpandedConfig() : super(FbWidgetType.expanded, FbChildType.single);

  @override
  List<BaseFbInput> getInputs() {
    return [flexInput];
  }

  @override
  FbExpandedStyles getWidgetStyles() {
    return FbExpandedStyles(id, widgetType, flexInput.value);
  }

  @override
  String generateCode(String? childCode, int level) {
    final widgetCode = {
      '_name': 'Expanded',
      'flex': nullMapper(
        value: flexInput.intValue,
        returnNullChecks: [(v) => v == 0],
      ),
      'child': childCode,
    };

    return getCode(widgetCode) ?? '';
  }
}

class FbExpandedStyles extends BaseFbStyles {
  final int flex;

  FbExpandedStyles(
    int id,
    FbWidgetType widgetType,
    this.flex,
  ) : super(id, widgetType);
}
