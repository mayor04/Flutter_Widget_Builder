import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

class FbColumnConfig extends BaseFbConfig<FbColumnStyles> {
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
    );
  }

  @override
  List<FbInputBase> getInputs() {
    // TODO: implement getInputs
    throw UnimplementedError();
  }
}

class FbColumnStyles extends BaseFbStyles {
  FbColumnStyles(int id, FbWidgetType widgetType) : super(id, widgetType);
}
