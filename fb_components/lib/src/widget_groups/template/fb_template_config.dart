import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';

const _type = FbWidgetType.text;

class FbTemplateConfig extends BaseFbConfig<FbTemplateStyles> with CodeGeneratorLogic {
  FbTemplateStyles? styles;

  FbTemplateConfig({String? id, this.styles}) : super(_type, FbChildType.none, id: id);

  factory FbTemplateConfig.fromJson(Map<String, dynamic> json) {
    return FbTemplateConfig(
      id: json['id'],
      styles: json['styles'] == null
          ? null
          : FbTemplateStyles.fromJson(
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
  FbTemplateStyles getWidgetStyles() {
    return styles ??= FbTemplateStyles(
      id,
    );
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final widgetCode = {
      '_name': 'Template',
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbTemplateStyles styles) {
    this.styles = styles;
  }
}

class FbTemplateStyles extends BaseFbStyles {
  FbTemplateStyles(String id) : super(id, _type);

  // from json
  factory FbTemplateStyles.fromJson(Map<String, dynamic> json) {
    return FbTemplateStyles(
      json['id'],
    );
  }

  FbTemplateStyles copyWith({String? temp}) {
    return FbTemplateStyles(
      id,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
