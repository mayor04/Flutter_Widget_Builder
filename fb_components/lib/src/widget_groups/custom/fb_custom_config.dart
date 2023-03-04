import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';

const _type = FbWidgetType.text;

// TODO: write test for Custom
class FbCustomConfig extends BaseFbConfig<FbCustomStyles> with CodeGeneratorLogic {
  FbCustomStyles? styles;

  FbCustomConfig({String? id, this.styles}) : super(_type, FbChildType.none, id: id);

  factory FbCustomConfig.fromJson(Map<String, dynamic> json) {
    return FbCustomConfig(
      id: json['id'],
      styles: json['styles'] == null
          ? null
          : FbCustomStyles.fromJson(
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
  FbCustomStyles getWidgetStyles() {
    return styles ??= FbCustomStyles(
      id,
    );
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final widgetCode = {
      '_name': 'Custom',
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbCustomStyles styles) {
    this.styles = styles;
  }
}

class FbCustomStyles extends BaseFbStyles {
  FbCustomStyles(String id) : super(id, _type);

  // from json
  factory FbCustomStyles.fromJson(Map<String, dynamic> json) {
    return FbCustomStyles(
      json['id'],
    );
  }

  FbCustomStyles copyWith({String? temp}) {
    return FbCustomStyles(
      id,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
