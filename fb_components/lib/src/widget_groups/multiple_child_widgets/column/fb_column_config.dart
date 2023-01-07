import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

const _type = FbWidgetType.column;

class FbColumnConfig extends BaseFbConfig<FbColumnStyles> with CodeGeneratorLogic {
  FbColumnStyles? styles;

  FbColumnConfig({int? id, this.styles}) : super(_type, FbChildType.multiple, id: id);

  factory FbColumnConfig.fromJson(Map<String, dynamic> json) {
    return FbColumnConfig(
      id: json['id'] as int,
      styles: json['styles'] == null ? null : FbColumnStyles.fromJson(json['styles']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'styles': styles?.toJson(),
      };

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final widgetCode = {
      '_name': 'Row',
      'mainAxisAlignment': nullMapper(
        value: styles.mainAlignment.toString(),
        returnNullChecks: [(v) => v == 'MainAxisAlignment.start'],
      ),
      'crossAxisAlignment': nullMapper(
        value: styles.crossAlignment.toString(),
        returnNullChecks: [(v) => v == 'CrossAxisAlignment.center'],
      ),
      'mainAxisSize': nullMapper(
        value: styles.axisSize.toString(),
        returnNullChecks: [(v) => v == 'MainAxisSize.max'],
      ),
      'children': '[$childCode]',
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  List<BaseFbInput> getInputs() {
    return [
      // mainAxisInput,
      // crossAxisInput,
      // mainAxisSizeInput,
    ];
  }

  @override
  FbColumnStyles getWidgetStyles() {
    return styles ??= FbColumnStyles(
      id,
      mainAlignment: MainAxisAlignment.start,
      crossAlignment: CrossAxisAlignment.center,
      axisSize: MainAxisSize.max,
    );
  }

  @override
  void updateStyles(FbColumnStyles styles) {
    this.styles = styles;
  }
}

class FbColumnStyles extends BaseFbStyles {
  MainAxisAlignment mainAlignment;
  CrossAxisAlignment crossAlignment;
  MainAxisSize axisSize;

  FbColumnStyles(
    int id, {
    this.mainAlignment = MainAxisAlignment.start,
    this.crossAlignment = CrossAxisAlignment.center,
    this.axisSize = MainAxisSize.max,
  }) : super(id, _type);

  //from json
  factory FbColumnStyles.fromJson(Map<String, dynamic> json) {
    return FbColumnStyles(
      json['id'] as int,
      mainAlignment: (json['mainAxisAlignment'] as String).toEnum(MainAxisAlignment.values) ??
          MainAxisAlignment.start,
      crossAlignment: (json['crossAxisAlignment'] as String).toEnum(CrossAxisAlignment.values) ??
          CrossAxisAlignment.center,
      axisSize: (json['mainAxisSize'] as String).toEnum(MainAxisSize.values) ?? MainAxisSize.max,
    );
  }

  // CopyWith
  FbColumnStyles copyWith({
    MainAxisAlignment? mainAlignment,
    CrossAxisAlignment? crossAlignment,
    MainAxisSize? axisSize,
  }) {
    return FbColumnStyles(
      id,
      mainAlignment: mainAlignment ?? this.mainAlignment,
      crossAlignment: crossAlignment ?? this.crossAlignment,
      axisSize: axisSize ?? this.axisSize,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'mainAxisAlignment': mainAlignment.name,
        'crossAxisAlignment': crossAlignment.name,
        'mainAxisSize': axisSize.name,
      };
}
