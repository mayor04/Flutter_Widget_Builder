import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

const _type = FbWidgetType.stack;

class FbStackConfig extends BaseFbConfig<FbStackStyles> with CodeGeneratorLogic {
  FbStackStyles? styles;

  FbStackConfig({String? id, this.styles})
      : super(
          _type,
          FbChildType.multiple,
          id: id,
        );

  factory FbStackConfig.fromJson(Map<String, dynamic> json) {
    return FbStackConfig(
      id: json['id'] as String,
      styles: json['styles'] == null
          ? null
          : FbStackStyles.fromJson(
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
  getWidgetStyles() {
    return styles ??= FbStackStyles(
      id,
      stackFit: StackFit.loose,
    );
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final widgetCode = {
      '_name': 'Stack',
      'mainAxisAlignment': nullMapper(
        value: styles.stackFit.toString(),
        returnNullChecks: [(v) => v == 'StackFit.loose'],
      ),
      'children': '[$childCode]',
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbStackStyles styles) {
    this.styles = styles;
  }
}

class FbStackStyles extends BaseFbStyles {
  final StackFit stackFit;

  FbStackStyles(
    String id, {
    this.stackFit = StackFit.loose,
  }) : super(id, _type);

  factory FbStackStyles.fromJson(Map<String, dynamic> json) {
    return FbStackStyles(
      json['id'] as String,
      stackFit: (json['stackFit'] as String).toEnum(StackFit.values) ?? StackFit.loose,
    );
  }

  FbStackStyles copyWith({
    StackFit? stackFit,
  }) {
    return FbStackStyles(
      id,
      stackFit: stackFit ?? this.stackFit,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'stackFit': stackFit.name,
      };
}
