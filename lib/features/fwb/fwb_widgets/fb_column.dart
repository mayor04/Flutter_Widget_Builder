import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_widget.dart';

class FbColumnConfig extends FbWidgetConfig<FbColumnData> {
  FbColumnConfig() : super(FbWidgetType.column, FbChildType.multiple);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  FbColumnData getWidgetConfig() {
    return FbColumnData(
      id,
      widgetType,
      height: 50,
      width: 50,
      color: Colors.red,
    );
  }

  @override
  List<FbInputBase> getInputs() {
    // TODO: implement getInputs
    throw UnimplementedError();
  }
}

class FbColumnData extends FbWidgetData {
  final int height;
  final int width;
  final Color color;

  FbColumnData(
    int id,
    FbWidgetType widgetType, {
    required this.height,
    required this.width,
    required this.color,
  }) : super(id, widgetType);
}
