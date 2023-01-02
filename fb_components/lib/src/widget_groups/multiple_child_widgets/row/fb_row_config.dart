import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/dropdown_input.dart';
import 'package:flutter/material.dart';

class FbRowConfig extends BaseFbConfig<FbRowStyles> with CodeGeneratorLogic {
  @visibleForTesting
  final mainAxisInput = FbInputDataDropdown(
    'MainAxisAlign',
    defaultEnum: MainAxisAlignment.start,
    list: MainAxisAlignment.values,
  );

  @visibleForTesting
  final crossAxisInput = FbInputDataDropdown(
    'CrossAxisAlign',
    defaultEnum: CrossAxisAlignment.center,
    list: CrossAxisAlignment.values,
  );

  @visibleForTesting
  final mainAxisSizeInput = FbInputDataDropdown(
    'MainAxisSize',
    defaultEnum: MainAxisSize.max,
    list: MainAxisSize.values,
  );

  FbRowConfig({int? id}) : super(FbWidgetType.row, FbChildType.multiple, id: id);

  factory FbRowConfig.fronJson(Map<String, dynamic> json) {
    final config = FbRowConfig(id: json['id'] as int);
    config.mainAxisInput.value =
        MainAxisAlignment.values.where((element) => element == json['mainAxisAlignment']).first;
    config.crossAxisInput.value =
        CrossAxisAlignment.values.where((element) => element == json['crossAxisAlignment']).first;
    config.mainAxisSizeInput.value =
        MainAxisSize.values.where((element) => element == json['mainAxisSize']).first;
    return config;
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'mainAxisAlignment': mainAxisInput.value.name,
        'crossAxisAlignment': crossAxisInput.value.name,
        'mainAxisSize': mainAxisSizeInput.value.name,
      };

  @override
  List<BaseFbInput> getInputs() {
    return [
      mainAxisInput,
      crossAxisInput,
      mainAxisSizeInput,
    ];
  }

  @override
  FbRowStyles getWidgetStyles() {
    return FbRowStyles(
      id,
      widgetType,
      mainAlignment: mainAxisInput.value,
      crossAlignment: crossAxisInput.value,
      axisSize: mainAxisSizeInput.value,
    );
  }

  @override
  String generateCode(String? childCode) {
    final widgetCode = {
      '_name': 'Row',
      'mainAxisAlignment': nullMapper(
        value: mainAxisInput.value.toString(),
        returnNullChecks: [(v) => v == mainAxisInput.defaultEnum.toString()],
      ),
      'crossAxisAlignment': nullMapper(
        value: crossAxisInput.value.toString(),
        returnNullChecks: [(v) => v == crossAxisInput.defaultEnum.toString()],
      ),
      'mainAxisSize': nullMapper(
        value: mainAxisSizeInput.value.toString(),
        returnNullChecks: [(v) => v == mainAxisSizeInput.defaultEnum.toString()],
      ),
      'children': '[$childCode]',
    };

    return getCode(widgetCode) ?? '';
  }
}

class FbRowStyles extends BaseFbStyles {
  MainAxisAlignment mainAlignment;
  CrossAxisAlignment crossAlignment;
  MainAxisSize axisSize;

  FbRowStyles(
    int id,
    FbWidgetType widgetType, {
    required this.mainAlignment,
    required this.crossAlignment,
    required this.axisSize,
  }) : super(id, widgetType);

  FbRowStyles copyWith({
    MainAxisAlignment? mainAlignment,
    CrossAxisAlignment? crossAlignment,
    MainAxisSize? axisSize,
  }) {
    return FbRowStyles(
      id,
      widgetType,
      mainAlignment: mainAlignment ?? this.mainAlignment,
      crossAlignment: crossAlignment ?? this.crossAlignment,
      axisSize: axisSize ?? this.axisSize,
    );
  }
}
