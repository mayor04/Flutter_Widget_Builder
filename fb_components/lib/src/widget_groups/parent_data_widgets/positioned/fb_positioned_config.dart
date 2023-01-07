import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';

const _type = FbWidgetType.positioned;

class FbPositionedConfig extends BaseFbConfig<FbPositionedStyles> with CodeGeneratorLogic {
  FbPositionedStyles? styles;

  FbPositionedConfig({String? id, this.styles}) : super(_type, FbChildType.single, id: id);

  factory FbPositionedConfig.fromJson(Map<String, dynamic> json) {
    return FbPositionedConfig(
      id: json['id'],
      styles: json['styles'] == null ? null : FbPositionedStyles.fromJson(json['styles']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'styles': styles?.toJson(),
      };

  @override
  FbPositionedStyles getWidgetStyles() {
    return styles ??= FbPositionedStyles(id);
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final widgetCode = {
      '_name': 'Positioned',
      'top': styles.top,
      'left': styles.left,
      'right': styles.right,
      'bottom': styles.bottom,
      'child': childCode,
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbPositionedStyles styles) {
    this.styles = styles;
  }
}

class FbPositionedStyles extends BaseFbStyles {
  final double? top;
  final double? right;
  final double? left;
  final double? bottom;

  FbPositionedStyles(
    String id, {
    this.top,
    this.right,
    this.left,
    this.bottom,
  }) : super(id, _type);

  FbPositionedStyles copyWith({
    double? top,
    double? right,
    double? left,
    double? bottom,
  }) {
    return FbPositionedStyles(
      id,
      top: top ?? this.top,
      right: right ?? this.right,
      left: left ?? this.left,
      bottom: bottom ?? this.bottom,
    );
  }

  // to json
  factory FbPositionedStyles.fromJson(Map<String, dynamic> json) {
    return FbPositionedStyles(
      json['id'],
      top: json['top'],
      right: json['right'],
      left: json['left'],
      bottom: json['bottom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'top': top,
      'right': right,
      'left': left,
      'bottom': bottom,
    };
  }
}
