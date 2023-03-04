import 'package:fb_core/fb_core.dart';

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

  @override
  String toString() {
    return 'InputParams(id: $id, name: $name, type: $type, isRequired: $isRequired,  previewValue: $previewValue )';
  }
}

enum InputParamsType { string, int, double, bool, color, font, text, list, map, widget, model }
