import 'package:fb_core/fb_core.dart';

typedef GlobalParamsMap = Map<String, InputParams>;

class InputParams<T> {
  final String id;
  final String name;
  final InputParamsType type;
  final T? value;
  final T? defaultValue;
  final T previewValue;
  final bool isRequired;

  InputParams({
    String? id,
    required this.name,
    required this.type,
    this.value,
    this.defaultValue,
    required this.isRequired,
    required this.previewValue,
  }) : id = id ?? IdGen.generateIdString();

  factory InputParams.fromJson(Map<String, dynamic> json) {
    return InputParams(
      id: json['id'] as String,
      name: json['name'] as String,
      type: InputParamsType.values.firstWhere((e) => e.name == json['type']),
      value: json['value'] as T,
      defaultValue: json['defaultValue'] as T,
      isRequired: json['isRequired'] as bool,
      previewValue: json['previewValue'] as T,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'value': value,
      'defaultValue': defaultValue,
      'isRequired': isRequired,
      'previewValue': previewValue,
    };
  }

  @override
  String toString() {
    return 'InputParams(id: $id, name: $name, type: $type, isRequired: $isRequired,  previewValue: $previewValue )';
  }
}

enum InputParamsType { string, int, double, bool, color, font, text, list, map, widget, model }
