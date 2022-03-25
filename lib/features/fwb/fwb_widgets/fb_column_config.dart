import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

class FbColumnConfig extends BaseFbConfig<FbColumnStyles> {
  var mainAxisInput = FbInputDataDropdown(
    'MainAxisAlign',
    defaultString: MainAxisAlignment.start.name,
    list: MainAxisAlignment.values.map((e) => e.name).toList(),
  );

  var crossAxisInput = FbInputDataDropdown(
    'CrossAxisAlign',
    defaultString: CrossAxisAlignment.center.name,
    list: CrossAxisAlignment.values.map((e) => e.name).toList(),
  );

  var mainAxisSizeInput = FbInputDataDropdown(
    'MainAxisSize',
    defaultString: MainAxisSize.max.name,
    list: MainAxisSize.values.map((e) => e.name).toList(),
  );

  FbColumnConfig() : super(FbWidgetType.column, FbChildType.multiple);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  FbColumnStyles getWidgetStyles() {
    return FbColumnStyles(
      id,
      widgetType,
      mainAlignment: mainAxisSizeInput.value,
      crossAlignment: crossAxisInput.value,
      axisSize: mainAxisSizeInput.value,
    );
  }

  @override
  List<FbInputBase> getInputs() {
    return [
      mainAxisInput,
      crossAxisInput,
      mainAxisSizeInput,
    ];
  }
}

class FbColumnStyles extends BaseFbStyles {
  String mainAlignment;
  String crossAlignment;
  String axisSize;

  FbColumnStyles(
    int id,
    FbWidgetType widgetType, {
    required this.mainAlignment,
    required this.crossAlignment,
    required this.axisSize,
  }) : super(id, widgetType);
}
