import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';

const _type = FbWidgetType.sizedBox;

class FbSizedBoxConfig extends BaseFbConfig<FbSizedBoxStyles> with CodeGeneratorLogic {
  FbSizedBoxStyles? styles;

  FbSizedBoxConfig({int? id, this.styles})
      : super(FbWidgetType.sizedBox, FbChildType.single, id: id);

  factory FbSizedBoxConfig.fromJson(Map<String, dynamic> json) {
    return FbSizedBoxConfig(
      id: json['id'],
      styles: FbSizedBoxStyles.fromJson(json['styles']),
    );
  }
  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'styles': styles?.toJson(),
      };

  @override
  List<BaseFbInput> getInputs() {
    return [
      // heightInput,
      // widthInput,
    ];
  }

  @override
  FbSizedBoxStyles getWidgetStyles() {
    return styles ??= FbSizedBoxStyles(id);
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();
    final widgetCode = {
      '_name': 'SizedBox',
      'height': styles.height,
      'width': styles.width,
      'child': childCode,
    };

    return getCode(widgetCode) ?? '';
  }

  @override
  void updateStyles(FbSizedBoxStyles styles) {
    this.styles = styles;
  }
}

class FbSizedBoxStyles extends BaseFbStyles {
  final double? height;
  final double? width;

  FbSizedBoxStyles(
    int id, {
    this.height,
    this.width,
  }) : super(id, _type);

  // fromJson
  factory FbSizedBoxStyles.fromJson(Map<String, dynamic> json) {
    return FbSizedBoxStyles(
      json['id'],
      height: json['height'],
      width: json['width'],
    );
  }

  // copy with
  FbSizedBoxStyles copyWith({
    int? id,
    FbWidgetType? widgetType,
    double? height,
    double? width,
  }) {
    return FbSizedBoxStyles(
      id ?? this.id,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'height': height,
        'width': width,
      };
}
