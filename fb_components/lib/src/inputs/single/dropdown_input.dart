import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';

/// This defines the style of the input that should be displayed
/// `FbInputDataDropdown<T>` tells the ui to fill the all the space horizontally
/// and mostly used for item that have multiple options to select from
class FbInputDataDropdown<T> extends BaseFbInput<T> {
  final List<Enum> list;
  final T defaultEnum;
  FbInputDataDropdown(
    String title, {
    required this.list,
    required this.defaultEnum,
  }) : super(title, defaultEnum, FbInputType.dropDownEnum);
}

/// This defines the style of the input that should be displayed
/// `FbInputDataDropdown<T>` tells the ui to fill the all the space horizontally
/// and mostly used for item that have multiple options to select from
class FbInputDataDropdownMap<T> extends BaseFbInput {
  final Map<String, T> map;
  final String defaultValue;
  FbInputDataDropdownMap(String title, {required this.map, required this.defaultValue})
      : super(title, defaultValue, FbInputType.dropDownMap);

  //Since the value is a string it needs to be converted to the main
  //real value that would be used
  T? get mapValue => map[value];
}
