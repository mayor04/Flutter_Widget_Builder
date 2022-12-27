import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/color_input.dart';
import 'package:fb_components/src/inputs/single/dropdown_input.dart';
import 'package:fb_components/src/inputs/single/expanded_input.dart';
import 'package:fb_components/src/inputs/single/text_input.dart';
import 'package:flutter/material.dart';

class FbTextConfig extends BaseFbConfig<FbTextStyles> with CodeGeneratorLogic {
  var textInput = FbInputDataText('Text', '');
  var fontSizeInput = FbInputDataExpanded<double>('Font Size', 13);
  var colorInput = FbInputDataColor('Color', int.parse('0xFF000000'));
  var fontWeightInput = FbInputDataDropdownMap(
    'Font weight',
    defaultValue: FbTextStyles.defaultWeight,
    map: FbTextStyles.fontWeightMap,
  );

  FbTextConfig({int? id}) : super(FbWidgetType.text, FbChildType.none, id: id);

  @override
  List<BaseFbInput> getInputs() {
    return [textInput, fontSizeInput, colorInput, fontWeightInput];
  }

  @override
  FbTextStyles getWidgetStyles() {
    return FbTextStyles(
      id,
      widgetType,
      text: textInput.value,
      fontSize: fontSizeInput.value,
      colorValue: colorInput.value,
      fontWeight: fontWeightInput.mapValue,
    );
  }

  @override
  String generateCode(String? childCode, int level) {
    final widgetCode = {
      '_name': 'Text',
      '': "'${textInput.value}'",
      'style': {
        '_name': 'TextStyle',
        'fontSize': fontSizeInput.intValue,
        'color': nullMapper(
          prefix: 'Color(',
          value: colorInput.intValue,
          suffix: ')',
          returnNullChecks: [(value) => value == 0],
        ),
        'fontWeight': nullMapper(
          prefix: 'FontWeight.',
          value: fontWeightInput.value,
          returnNullChecks: [(v) => v == FbTextStyles.defaultWeight],
        ),
      }
    };

    return getCode(widgetCode) ?? '';
  }
}

class FbTextStyles extends BaseFbStyles {
  final String text;
  final int colorValue;
  final FontWeight? fontWeight;
  final double? fontSize;

  FbTextStyles(
    int id,
    FbWidgetType widgetType, {
    required this.text,
    required this.colorValue,
    this.fontWeight,
    this.fontSize,
  }) : super(id, widgetType);

  static String defaultWeight = 'none';

  static Map<String, FontWeight?> fontWeightMap = () {
    Map<String, FontWeight?> weightMap = {'none': null};

    for (var weight in FontWeight.values) {
      String key = weight.toString().split('.')[1];
      weightMap[key] = weight;
    }

    return weightMap;
  }();
}
