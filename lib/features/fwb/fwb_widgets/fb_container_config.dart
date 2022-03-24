import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

class FbContainerConfig extends FbWidgetConfig<FbContainerStyles> {
  var heightInput = FbInputDataSmall<double>('Height', 150);
  var widthInput = FbInputDataSmall<double>('Width', 150);

  FbContainerConfig() : super(FbWidgetType.container, FbChildType.single);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  var colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Color.fromARGB(255, 194, 151, 139),
    Color.fromARGB(255, 158, 180, 228),
    Color.fromARGB(255, 10, 51, 85),
    Color.fromARGB(255, 235, 226, 146),
    Color.fromARGB(255, 230, 155, 132),
  ];
  Color? mcolor;

  @override
  FbContainerStyles getWidgetStyles() {
    mcolor ??= colors[Random().nextInt(4)];

    return FbContainerStyles(
      id,
      widgetType,
      height: heightInput.value,
      width: widthInput.value,
      color: mcolor,
    );
  }

  @override
  List<FbInputBase> getInputs() {
    return [
      FbGroupHWData('', input1: heightInput, input2: widthInput),
    ];
  }
}

///Contains styles of the container, ussualy used to style the widget
class FbContainerStyles extends FbWidgetStyles {
  final double height;
  final double width;
  final Color? color;

  FbContainerStyles(
    int id,
    FbWidgetType widgetType, {
    required this.height,
    required this.width,
    required this.color,
  }) : super(id, widgetType);
}
