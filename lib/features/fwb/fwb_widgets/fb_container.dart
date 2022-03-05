import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_widget.dart';

class FbContainer extends FbWidget {
  FbContainer() : super(FbWidgetType.container, FbChildType.single);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  FbWidgetConfig getWidgetConfig() {
    return FbContainerConfig(
      id,
      widgetType,
      height: 50,
      width: 50,
      color: Colors.red,
    );
  }
}

class FbContainerConfig extends FbWidgetConfig {
  final int height;
  final int width;
  final Color color;

  FbContainerConfig(
    int id,
    FbWidgetType widgetType, {
    required this.height,
    required this.width,
    required this.color,
  }) : super(id, widgetType);
}
