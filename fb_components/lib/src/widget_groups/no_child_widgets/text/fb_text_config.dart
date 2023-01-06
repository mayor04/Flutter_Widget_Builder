import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:flutter/material.dart';

const _type = FbWidgetType.text;

class FbTextConfig extends BaseFbConfig<FbTextStyles> with CodeGeneratorLogic {
  FbTextStyles? styles;

  FbTextConfig({int? id, this.styles}) : super(_type, FbChildType.none, id: id);

  factory FbTextConfig.fromJson(Map<String, dynamic> json) {
    return FbTextConfig(
      id: json['id'],
      styles: FbTextStyles.fromJson(json['styles']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'text': styles?.text,
        'fontSize': styles?.fontSize,
        'color': styles?.color.value,
        'fontWeight': styles?.fontWeight,
      };

  @override
  List<BaseFbInput> getInputs() {
    return [
      // textInput,
      // fontSizeInput,
      // colorInput,
      // fontWeightInput,
    ];
  }

  @override
  FbTextStyles getWidgetStyles() {
    return styles ??= FbTextStyles(
      id,
      text: '',
      fontSize: 13,
      colorValue: int.parse('0xFF000000'),
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    // TODO: implement special character fix
    final text = styles.text;
    bool useMultiLineString = false;

    if (text.contains("'") || text.contains('"')) {
      useMultiLineString = true;
    }

    final widgetCode = {
      '_name': 'Text',
      '': useMultiLineString ? "'''$text'''" : "'$text'",
      'style': {
        '_name': 'TextStyle',
        'fontSize': styles.fontSize,
        'color': nullMapper(
          prefix: 'Color(',
          value: styles.color.value,
          suffix: ')',
          returnNullChecks: [(value) => value == 0],
        ),
        'fontWeight': nullMapper(
          prefix: 'FontWeight.',
          value: styles.fontWeight.toString(),
          returnNullChecks: [(v) => v == FbTextStyles.defaultWeight],
        ),
      }
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbTextStyles styles) {
    this.styles = styles;
  }
}

class FbTextStyles extends BaseFbStyles {
  final String text;
  final int colorValue;
  final Color color;
  final FontWeight? fontWeight;
  final double? fontSize;

  FbTextStyles(
    int id, {
    this.text = '',
    this.colorValue = 0,
    required this.color,
    this.fontWeight,
    this.fontSize,
  }) : super(id, _type);

  // from json
  factory FbTextStyles.fromJson(Map<String, dynamic> json) {
    return FbTextStyles(
      json['id'],
      text: json['text'],
      fontSize: json['fontSize'],
      colorValue: json['colorValue'],
      fontWeight: json['fontWeight'],
      color: Color(json['color']),
    );
  }

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
      text: text ?? this.text,
      color: color ?? this.color,
      colorValue: colorValue ?? this.colorValue,
      fontWeight: fontWeight ?? this.fontWeight,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'text': text,
        'fontSize': fontSize,
        'color': color.value,
        'fontWeight': fontWeight.toString().split('.')[1],
      };
}
