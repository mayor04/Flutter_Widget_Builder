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
  @visibleForTesting
  final textInput = FbInputDataText('Text', '');
  @visibleForTesting
  final fontSizeInput = FbInputDataExpanded<double>('Font Size', 13);
  @visibleForTesting
  final colorInput = FbInputDataColor('Color', int.parse('0xFF000000'));

  @visibleForTesting
  final fontWeightInput = FbInputDataDropdownMap(
    'Font weight',
    defaultValue: FbTextStyles.defaultWeight,
    map: FbTextStyles.fontWeightMap,
  );

  FbTextConfig({int? id}) : super(FbWidgetType.text, FbChildType.none, id: id);

  factory FbTextConfig.fromJson(Map<String, dynamic> json) {
    return FbTextConfig(
      id: json['id'],
    )
      ..textInput.value = json['text']
      ..fontSizeInput.value = json['fontSize']?.toDouble()
      ..colorInput.value = json['colorValue']
      ..fontWeightInput.value = json['fontWeight'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': widgetType.name,
      'text': textInput.value,
      'fontSize': fontSizeInput.value,
      'colorValue': colorInput.value,
      'fontWeight': fontWeightInput.value,
    };
  }

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
      color: Colors.black,
      fontWeight: fontWeightInput.mapValue,
    );
  }

  @override
  String generateCode(String? childCode) {
    // TODO: implement special character fix
    final text = textInput.value;
    bool useMultiLineString = false;

    if (text.contains("'") || text.contains('"')) {
      useMultiLineString = true;
    }

    final widgetCode = {
      '_name': 'Text',
      '': useMultiLineString ? "'''$text'''" : "'${textInput.value}'",
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
  final Color color;
  final FontWeight? fontWeight;
  final double? fontSize;

  FbTextStyles(
    int id,
    FbWidgetType widgetType, {
    required this.text,
    required this.colorValue,
    required this.color,
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

  copyWith({
    String? text,
    int? colorValue,
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
  }) {
    return FbTextStyles(
      id,
      widgetType,
      text: text ?? this.text,
      color: color ?? this.color,
      colorValue: colorValue ?? this.colorValue,
      fontWeight: fontWeight ?? this.fontWeight,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
