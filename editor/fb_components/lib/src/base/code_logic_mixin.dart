import 'package:fb_components/fb_components.dart';

mixin CodeGeneratorLogic<T extends BaseFbStyles> on BaseFbConfig<T> {
  /// Generates the code for the widget, Include the _name key in the map
  /// which will be the name of the widget
  String? getCode(Map<String, dynamic> mapCode, {bool isFirst = true}) {
    final codeBuffer = StringBuffer();
    final name = mapCode['_name'];
    final keys = mapCode.keys;

    // increases count when any item is null
    int count = 0;

    // example `Container(` or `BoxDecoration(`
    codeBuffer.writeln('$name(');

    for (var key in keys) {
      if (key == '_name') continue;

      var value = mapCode[key];
      var valueCode = value;

      if (value is Map) {
        valueCode = getCode(
          value as Map<String, dynamic>,
          isFirst: false,
        );
      }

      if (valueCode == null || valueCode is String && valueCode.isEmpty) {
        count++;
        continue;
      }

      // If the key is empty this mean it is not a named argument
      // example BorderRadius.circular(5), 5 doesn't have a key
      if (key.isNotEmpty) {
        codeBuffer.write('$key:');
      }

      // Dont put commas for child or map since commas has been added
      if (value is Map || key == 'child') {
        codeBuffer.write(valueCode);
      } else {
        codeBuffer.write('$valueCode,');
      }
    }

    // If all items in the widget is null no need to write
    if (count == keys.length - 1 && !isFirst) {
      return null;
    }

    codeBuffer.write('),');
    return codeBuffer.toString();
  }

  /// Provide a list of checks, if any of the check
  /// return true the nullMaper returns null
  nullMapper({
    Comparable? value,
    String prefix = '',
    String suffix = '',
    List<bool Function(dynamic value)>? returnNullChecks,
  }) {
    if (value == null) return null;

    // Returns null if the any of the checks returns true
    final checkList = (returnNullChecks ?? []).where(
      (checkFunction) => checkFunction(value),
    );

    if (checkList.isNotEmpty) {
      return null;
    }

    return '$prefix$value$suffix';
  }
}
