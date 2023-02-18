import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';
import 'package:flutter/material.dart';

const _type = FbWidgetType.icon;

class FbIconConfig extends BaseFbConfig<FbIconStyles> with CodeGeneratorLogic {
  FbIconStyles? styles;

  FbIconConfig({String? id, this.styles}) : super(_type, FbChildType.none, id: id);

  factory FbIconConfig.fromJson(Map<String, dynamic> json) {
    return FbIconConfig(
      id: json['id'],
      styles: json['styles'] == null
          ? null
          : FbIconStyles.fromJson(
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
  FbIconStyles getWidgetStyles() {
    return styles ??= FbIconStyles(
      id,
    );
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final widgetCode = {
      '_name': 'Icon',
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbIconStyles styles) {
    this.styles = styles;
  }
}

class FbIconStyles extends BaseFbStyles {
  FbIconStyles(
    String id, {
    this.size,
    this.color,
  }) : super(id, _type);

  final double? size;
  final Color? color;

  // from json
  factory FbIconStyles.fromJson(Map<String, dynamic> json) {
    return FbIconStyles(
      json['id'],
      size: json['size'],
      color: json['color'] == null ? null : Color(json['color']),
    );
  }

  // copy with
  FbIconStyles copyWith({
    double? size,
    Color? color,
  }) {
    return FbIconStyles(
      id,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'size': size,
        'color': color?.value,
      };
}
