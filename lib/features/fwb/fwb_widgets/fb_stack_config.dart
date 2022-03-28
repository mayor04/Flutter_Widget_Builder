import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

class FbStackConfig extends BaseFbConfig<FbStackStyles> {
  // var alignInput = FbInputDataDropdown<MainAxisAlignment>(
  //   'MainAxisAlign',
  //   defaultEnum: MainAxisAlignment.start,
  //   list: MainAxisAlignment.values,
  // );

  var fitInput = FbInputDataDropdown(
    'Alignment',
    defaultEnum: StackFit.loose,
    list: StackFit.values,
  );

  FbStackConfig() : super(FbWidgetType.stack, FbChildType.multiple);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  List<FbInputBase> getInputs() {
    return [
      fitInput,
    ];
  }

  @override
  getWidgetStyles() {
    return FbStackStyles(
      id,
      widgetType,
      stackFit: fitInput.value,
    );
  }
}

class FbStackStyles extends BaseFbStyles {
  // final Alignment alignment;
  final StackFit stackFit;

  FbStackStyles(
    int id,
    FbWidgetType widgetType, {
    // required this.alignment,
    required this.stackFit,
  }) : super(id, widgetType);
}
