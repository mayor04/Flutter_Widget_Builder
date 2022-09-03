import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/expanded_input.dart';

class FbExpandedConfig extends BaseFbConfig<FbExpandedStyles> {
  var flexInput = FbInputDataExpanded<int>('Flex', 1);

  FbExpandedConfig() : super(FbWidgetType.expanded, FbChildType.single);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  List<BaseFbInput> getInputs() {
    return [flexInput];
  }

  @override
  FbExpandedStyles getWidgetStyles() {
    return FbExpandedStyles(id, widgetType, flexInput.value);
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
