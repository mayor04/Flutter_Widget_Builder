import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';
import 'package:flutter/material.dart';

const _type = FbWidgetType.icon;

// TODO: write test for Icon
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
      icon: Icons.ac_unit,
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
    required this.icon,
    this.size,
    this.color,
  }) : super(id, _type);

  final double? size;
  final Color? color;
  final IconData icon;

  // from json
  factory FbIconStyles.fromJson(Map<String, dynamic> json) {
    return FbIconStyles(
      json['id'],
      icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
      size: json['size'],
      color: json['color'] == null ? null : Color(json['color']),
    );
  }

  // copy with
  FbIconStyles copyWith({
    double? size,
    Color? color,
    IconData? icon,
  }) {
    return FbIconStyles(
      id,
      size: size ?? this.size,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'size': size,
        'color': color?.value,
        'icon': icon.codePoint,
      };
}
