import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/dropdown_input.dart';
import 'package:flutter/material.dart';

class FbStackConfig extends BaseFbConfig<FbStackStyles> with CodeGeneratorLogic {
  // var alignInput = FbInputDataDropdown<MainAxisAlignment>(
  //   'MainAxisAlign',
  //   defaultEnum: MainAxisAlignment.start,
  //   list: MainAxisAlignment.values,
  // );

  @visibleForTesting
  final fitInput = FbInputDataDropdown(
    'Alignment',
    defaultEnum: StackFit.loose,
    list: StackFit.values,
  );

  FbStackConfig({int? id}) : super(FbWidgetType.stack, FbChildType.multiple, id: id);

  factory FbStackConfig.fromJson(Map<String, dynamic> json) {
    final config = FbStackConfig(id: json['id'] as int);
    // config.alignInput.value = MainAxisAlignment.values.where((element) => element == json['mainAxisAlignment']).first;
    config.fitInput.value = StackFit.values.where((element) => element == json['stackFit']).first;
    return config;
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': widgetType.name,
        'stackFit': fitInput.value.name,
      };

  @override
  List<BaseFbInput> getInputs() {
    return [
      fitInput,
    ];
  }

  @override
  getWidgetStyles() {
    return FbStackStyles(
      id,
      widgetType,
      stackFit: fitInput.value,
    );
  }

  @override
  String generateCode(String? childCode) {
    @override
    final widgetCode = {
      '_name': 'Stack',
      'mainAxisAlignment': nullMapper(
        value: fitInput.value.toString(),
        returnNullChecks: [(v) => v == fitInput.defaultEnum.toString()],
      ),
      'children': '[$childCode]',
    };

    return getCode(widgetCode) ?? '';
  }
}

class FbStackStyles extends BaseFbStyles {
  // final Alignment alignment;
  final StackFit stackFit;

  FbStackStyles(
    int id,
    FbWidgetType widgetType, {
    // required this.alignment,
    required this.stackFit,
  }) : super(id, widgetType);

  // copyWith
  FbStackStyles copyWith({
    // Alignment? alignment,
    StackFit? stackFit,
  }) {
    return FbStackStyles(
      id,
      widgetType,
      // alignment: alignment ?? this.alignment,
      stackFit: stackFit ?? this.stackFit,
    );
  }
}
