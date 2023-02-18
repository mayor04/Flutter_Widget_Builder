import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';

const _type = FbWidgetType.center;

class FbCenterConfig extends BaseFbConfig<FbCenterStyles> with CodeGeneratorLogic {
  FbCenterStyles? styles;

  FbCenterConfig({String? id, this.styles}) : super(_type, FbChildType.none, id: id);

  factory FbCenterConfig.fromJson(Map<String, dynamic> json) {
    return FbCenterConfig(
      id: json['id'],
      styles: json['styles'] == null
          ? null
          : FbCenterStyles.fromJson(
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
  FbCenterStyles getWidgetStyles() {
    return styles ??= FbCenterStyles(
      id,
    );
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final widgetCode = {
      '_name': 'Center',
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbCenterStyles styles) {
    this.styles = styles;
  }
}

class FbCenterStyles extends BaseFbStyles {
  FbCenterStyles(String id) : super(id, _type);

  // from json
  factory FbCenterStyles.fromJson(Map<String, dynamic> json) {
    return FbCenterStyles(
      json['id'],
    );
  }

  FbCenterStyles copyWith({String? temp}) {
    return FbCenterStyles(
      id,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
