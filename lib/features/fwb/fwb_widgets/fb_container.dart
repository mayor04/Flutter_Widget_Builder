import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_widget.dart';

class FbContainer extends FbWidget<FbContainerConfig> {
  var heightInput = FbInputSmall<double>('Height', 50);
  var widthInput = FbInputSmall<double>('Width', 50);

  FbContainer() : super(FbWidgetType.container, FbChildType.single);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  FbContainerConfig getWidgetConfig() {
    return FbContainerConfig(
      id,
      widgetType,
      height: heightInput.value,
      width: widthInput.value,
      // color: Colors.red,
    );
  }

  @override
  List<FbInput> getInputs() {
    return [
      FbGroup2Small('', input1: heightInput, input2: widthInput),
    ];
  }
}

class FbContainerConfig extends FbWidgetConfig {
  final double height;
  final double width;
  // final Color color;

  FbContainerConfig(
    int id,
    FbWidgetType widgetType, {
    required this.height,
    required this.width,
    // required this.color,
  }) : super(id, widgetType);
}
