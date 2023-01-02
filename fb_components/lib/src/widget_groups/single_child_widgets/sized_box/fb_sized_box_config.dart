import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/expanded_input.dart';
import 'package:flutter/foundation.dart';

class FbSizedBoxConfig extends BaseFbConfig<FbSizedBoxStyles> with CodeGeneratorLogic {
  @visibleForTesting
  final heightInput = FbInputDataExpanded<double?>('Height', null);

  @visibleForTesting
  final widthInput = FbInputDataExpanded<double?>('Width', null);

  FbSizedBoxConfig({int? id}) : super(FbWidgetType.sizedBox, FbChildType.single, id: id);

  factory FbSizedBoxConfig.fromJson(Map<String, dynamic> json) {
    return FbSizedBoxConfig(
      id: json['id'],
    )
      ..heightInput.value = json['height']?.toDouble()
      ..widthInput.value = json['width']?.toDouble();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': widgetType.name,
      'height': heightInput.value,
      'width': widthInput.value,
    };
  }

  @override
  List<BaseFbInput> getInputs() {
    return [
      heightInput,
      widthInput,
    ];
  }

  @override
  getWidgetStyles() {
    return FbSizedBoxStyles(
      id,
      widgetType,
      heightInput.value,
      widthInput.value,
    );
  }

  @override
  String generateCode(String? childCode) {
    final widgetCode = {
      '_name': 'SizedBox',
      'height': heightInput.intValue,
      'width': heightInput.intValue,
      'child': childCode,
    };

    return getCode(widgetCode) ?? '';
  }
}

class FbSizedBoxStyles extends BaseFbStyles {
  final double? height;
  final double? width;

  FbSizedBoxStyles(
    int id,
    FbWidgetType widgetType,
    this.height,
    this.width,
  ) : super(id, widgetType);

  // copy with
  FbSizedBoxStyles copyWith({
    int? id,
    FbWidgetType? widgetType,
    double? height,
    double? width,
  }) {
    return FbSizedBoxStyles(
      id ?? this.id,
      widgetType ?? this.widgetType,
      height ?? this.height,
      width ?? this.width,
    );
  }
}
