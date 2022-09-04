// import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

// class FbExpandedConfig extends BaseFbConfig<FbExpandedStyles> {
//   var flexInput = FbInputDataExpanded<int>('Flex', 1);

//   FbExpandedConfig() : super(FbWidgetType.expanded, FbChildType.single);

//   @override
//   String generateCode(String child) {
//     // TODO: implement generateCode
//     throw UnimplementedError();
//   }

//   @override
//   List<BaseFbInput> getInputs() {
//     return [flexInput];
//   }

//   @override
//   FbExpandedStyles getWidgetStyles() {
//     return FbExpandedStyles(id, widgetType, flexInput.value);
//   }
// }

// class FbExpandedStyles extends BaseFbStyles {
//   final int flex;

//   FbExpandedStyles(
//     int id,
//     FbWidgetType widgetType,
//     this.flex,
//   ) : super(id, widgetType);
// }
