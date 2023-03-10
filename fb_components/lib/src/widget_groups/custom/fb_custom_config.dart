import 'package:fb_components/fb_components.dart';
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

// TODO: implement parameters
class FbCustomStyles extends BaseFbStyles {
  FbCustomStyles(
    String id,
    // {
    // required this.parameters,
    // required this.values,
    // }
  ) : super(id, _type);

  // final GlobalParamsMap parameters;
  // final Map<String, dynamic> values;

  // from json
  factory FbCustomStyles.fromJson(Map<String, dynamic> json) {
    return FbCustomStyles(
      json['id'],
      // parameters: {},
      // values:
    );
  }

  FbCustomStyles copyWith() {
    return FbCustomStyles(
      id,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
