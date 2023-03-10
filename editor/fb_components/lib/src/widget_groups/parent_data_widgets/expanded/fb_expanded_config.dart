import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';

const _type = FbWidgetType.expanded;

class FbExpandedConfig extends BaseFbConfig<FbExpandedStyles> with CodeGeneratorLogic {
  FbExpandedStyles? styles;

  FbExpandedConfig({String? id, this.styles}) : super(_type, FbChildType.single, id: id);

  factory FbExpandedConfig.fromJson(Map<String, dynamic> json) {
    return FbExpandedConfig(
      id: json['id'],
      styles: json['styles'] == null
          ? null
          : FbExpandedStyles.fromJson(
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
  FbExpandedStyles getWidgetStyles() {
    return styles ??= FbExpandedStyles(id);
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final widgetCode = {
      '_name': 'Expanded',
      'flex': nullMapper(
        value: styles.flex,
        returnNullChecks: [(v) => v == 0],
      ),
      'child': childCode,
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbExpandedStyles styles) {
    this.styles = styles;
  }
}

class FbExpandedStyles extends BaseFbStyles {
  final int flex;

  FbExpandedStyles(
    String id, {
    this.flex = 1,
  }) : super(id, _type);

  // from json
  factory FbExpandedStyles.fromJson(Map<String, dynamic> json) {
    return FbExpandedStyles(
      json['id'],
      flex: json['flex']?.toInt(),
    );
  }

  // copyWith
  FbExpandedStyles copyWith({
    int? flex,
  }) {
    return FbExpandedStyles(
      id,
      flex: flex ?? this.flex,
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flex': flex,
    };
  }
}
