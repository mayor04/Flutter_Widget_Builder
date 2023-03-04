import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/params/style_params/style_params.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';
import 'package:flutter/material.dart';

const _type = FbWidgetType.text;

class FbTextConfig extends BaseFbConfig<FbTextStyles> with CodeGeneratorLogic {
  FbTextStyles? styles;

  FbTextConfig({String? id, this.styles}) : super(_type, FbChildType.none, id: id);

  factory FbTextConfig.fromJson(Map<String, dynamic> json) {
    return FbTextConfig(
      id: json['id'],
      styles: json['styles'] == null
          ? null
          : FbTextStyles.fromJson(
              (json['styles'] as Map<dynamic, dynamic>).cast(),
            ),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'styles': styles?.toJson(),
      };

  @override
  FbTextStyles getWidgetStyles() {
    return styles ??= FbTextStyles(
      id,
      text: '',
      fontSize: 13,
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
          // ignore: prefer_null_aware_operators
          value: styles.fontWeight == null ? null : styles.fontWeight.toString(),
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
  final Color color;
  final FontWeight? fontWeight;
  final double? fontSize;

  FbTextStyles(
    String id, {
    this.text = '',
    required this.color,
    this.fontWeight,
    this.fontSize,
    ParamsPlaceholder? params,
  }) : super(id, _type, params: params ?? {});

  // from json
  factory FbTextStyles.fromJson(Map<String, dynamic> json) {
    return FbTextStyles(
      json['id'],
      text: json['text'],
      fontSize: json['fontSize'],
      fontWeight: fontWeightMap[(json['fontWeight'] as String)],
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
        if (fontWeight != null) 'fontWeight': fontWeight.toString().split('.')[1],
      };
}

extension FbTextParams on FbTextStyles {
  String get textSn => 'text';
  String get colorSn => 'color';
  String get fontWeightSn => 'fontWeight';
  String get fontSizeSn => 'fontSize';

  StyleParams? get textParamsRef => params[textSn];
  StyleParams? get colorParamsRef => params[colorSn];
}
