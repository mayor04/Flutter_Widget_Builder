import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

const _type = FbWidgetType.row;

class FbRowConfig extends BaseFbConfig<FbRowStyles> with CodeGeneratorLogic {
  FbRowStyles? styles;

  FbRowConfig({String? id, this.styles})
      : super(
          _type,
          FbChildType.multiple,
          id: id,
        );

  factory FbRowConfig.fromJson(Map<String, dynamic> json) {
    return FbRowConfig(
      id: json['id'] as String,
      styles: json['styles'] == null
          ? null
          : FbRowStyles.fromJson(
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
  FbRowStyles getWidgetStyles() {
    return styles ??= FbRowStyles(id);
  }

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
  void updateStyles(FbRowStyles styles) {
    this.styles = styles;
  }
}

class FbRowStyles extends BaseFbStyles {
  MainAxisAlignment mainAlignment;
  CrossAxisAlignment crossAlignment;
  MainAxisSize axisSize;

  FbRowStyles(
    String id, {
    this.mainAlignment = MainAxisAlignment.start,
    this.crossAlignment = CrossAxisAlignment.center,
    this.axisSize = MainAxisSize.max,
  }) : super(id, _type);

  // from json
  factory FbRowStyles.fromJson(Map<String, dynamic> json) {
    return FbRowStyles(
      json['id'] as String,
      mainAlignment: (json['mainAxisAlignment'] as String).toEnum(MainAxisAlignment.values) ??
          MainAxisAlignment.start,
      crossAlignment: (json['crossAxisAlignment'] as String).toEnum(CrossAxisAlignment.values) ??
          CrossAxisAlignment.center,
      axisSize: (json['mainAxisSize'] as String).toEnum(MainAxisSize.values) ?? MainAxisSize.max,
    );
  }

  FbRowStyles copyWith({
    MainAxisAlignment? mainAlignment,
    CrossAxisAlignment? crossAlignment,
    MainAxisSize? axisSize,
  }) {
    return FbRowStyles(
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
