import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/groups/double_inputs.dart';
import 'package:fb_components/src/inputs/single/wrap_input.dart';
import 'package:flutter/foundation.dart';

class FbPositionedConfig extends BaseFbConfig<FbPositionedStyles> with CodeGeneratorLogic {
  @visibleForTesting
  final topInput = FbInputDataWrap<double?>('Top', null);

  @visibleForTesting
  final rightInput = FbInputDataWrap<double?>('Right', null);

  @visibleForTesting
  final leftInput = FbInputDataWrap<double?>('Left', null);

  @visibleForTesting
  final bottomInput = FbInputDataWrap<double?>('Bottom', null);

  FbPositionedConfig({int? id}) : super(FbWidgetType.positioned, FbChildType.single, id: id);

  factory FbPositionedConfig.fromJson(Map<String, dynamic> json) {
    return FbPositionedConfig(
      id: json['id'],
    )
      ..topInput.value = json['top']?.toDouble()
      ..rightInput.value = json['right']?.toDouble()
      ..leftInput.value = json['left']?.toDouble()
      ..bottomInput.value = json['bottom']?.toDouble();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': widgetType.name,
      'top': topInput.value,
      'right': rightInput.value,
      'left': leftInput.value,
      'bottom': bottomInput.value,
    };
  }

  @override
  List<BaseFbInput> getInputs() {
    return [
      FbGroupDoubleInputs('', input1: topInput, input2: leftInput),
      FbGroupDoubleInputs('', input1: rightInput, input2: bottomInput),
    ];
  }

  @override
  FbPositionedStyles getWidgetStyles() {
    return FbPositionedStyles(
      id,
      widgetType,
      top: topInput.value,
      bottom: bottomInput.value,
      right: rightInput.value,
      left: leftInput.value,
    );
  }

  @override
  String generateCode(String? childCode) {
    final widgetCode = {
      '_name': 'Positioned',
      'top': topInput.intValue,
      'left': leftInput.intValue,
      'right': rightInput.intValue,
      'bottom': bottomInput.intValue,
      'child': childCode,
    };

    return getCode(widgetCode) ?? '';
  }
}

class FbPositionedStyles extends BaseFbStyles {
  final double? top;
  final double? right;
  final double? left;
  final double? bottom;

  FbPositionedStyles(
    int id,
    FbWidgetType widgetType, {
    this.top,
    this.right,
    this.left,
    this.bottom,
  }) : super(id, widgetType);

  FbPositionedStyles copyWith({
    double? top,
    double? right,
    double? left,
    double? bottom,
  }) {
    return FbPositionedStyles(
      id,
      widgetType,
      top: top ?? this.top,
      right: right ?? this.right,
      left: left ?? this.left,
      bottom: bottom ?? this.bottom,
    );
  }
}
