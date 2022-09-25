import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/dropdown_input.dart';
import 'package:flutter/material.dart';

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
  String generateCode(String? childCode, int level) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  List<BaseFbInput> getInputs() {
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
