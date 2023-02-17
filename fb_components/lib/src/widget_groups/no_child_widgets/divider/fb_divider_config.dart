import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';
import 'package:flutter/material.dart';

const _type = FbWidgetType.divider;

class FbDividerConfig extends BaseFbConfig<FbDividerStyles> with CodeGeneratorLogic {
  FbDividerStyles? styles;

  FbDividerConfig({String? id, this.styles}) : super(_type, FbChildType.none, id: id);

  factory FbDividerConfig.fromJson(Map<String, dynamic> json) {
    return FbDividerConfig(
      id: json['id'],
      styles: json['styles'] == null
          ? null
          : FbDividerStyles.fromJson(
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
  FbDividerStyles getWidgetStyles() {
    return styles ??= FbDividerStyles(
      id,
    );
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final widgetCode = {
      '_name': 'Divider',
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbDividerStyles styles) {
    this.styles = styles;
  }
}

class FbDividerStyles extends BaseFbStyles {
  FbDividerStyles(
    String id, {
    this.height,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
  }) : super(id, _type);

  final double? height;
  final Color? color;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  // from json
  factory FbDividerStyles.fromJson(Map<dynamic, dynamic> json) {
    return FbDividerStyles(
      json['id'],
      height: json['height'],
      color: json['color'] == null ? null : Color(json['color']),
      thickness: json['thickness'],
      indent: json['indent'],
      endIndent: json['endIndent'],
    );
  }

  // copy with
  FbDividerStyles copyWith({
    double? height,
    Color? color,
    double? thickness,
    double? indent,
    double? endIndent,
  }) {
    return FbDividerStyles(
      id,
      height: height ?? this.height,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      indent: indent ?? this.indent,
      endIndent: endIndent ?? this.endIndent,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'height': height,
        'color': color?.value,
        'thickness': thickness,
        'indent': indent,
        'endIndent': endIndent,
      };
}
