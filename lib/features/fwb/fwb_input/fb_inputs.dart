import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';

///This defines the style of inputs that allows color selection
///`FbInputDataColor<T>` tells the ui to fill the all the space horizontally
class FbInputDataColor extends FbInputBase<int> {
  FbInputDataColor(String title, int value)
      : super(title, value, FbInputType.color);
}

///This defines the style of the input that should be displayed
///`FbInputDataDropdown<T>` tells the ui to fill the all the space horizontally
///and mostly used for item that have multiple options to select from
class FbInputDataDropdown<T> extends FbInputBase<T> {
  final List<Enum> list;
  final T defaultEnum;
  FbInputDataDropdown(
    String title, {
    required this.list,
    required this.defaultEnum,
  }) : super(title, defaultEnum, FbInputType.dropDownEnum);
}

///This defines the style of the input that should be displayed
///`FbInputDataDropdown<T>` tells the ui to fill the all the space horizontally
///and mostly used for item that have multiple options to select from
class FbInputDataDropdownMap<T> extends FbInputBase {
  final Map<String, T> map;
  final String defaultValue;
  FbInputDataDropdownMap(String title,
      {required this.map, required this.defaultValue})
      : super(title, defaultValue, FbInputType.dropDownMap);

  //Since the value is a string it needs to be converted to the main
  //real value that would be used
  T? get mapValue => map[value];
}

///This defines the style of the input that should be displayed
///`FbInputDataExpanded<T>` tells the ui to fill the all the space horizontally
class FbInputDataExpanded<T extends num?> extends FbInputBase<T> {
  FbInputDataExpanded(String title, T value)
      : super(title, value, FbInputType.expanded);
}

///This defines the style of the input that should be displayed
///`FbInputDataLTRB<T>` tells the ui to fill the all the space horizontally
///and mostly used for item like `padding`, `margin`, `border radius`
class FbInputDataLTRB<T extends List?> extends FbInputBase<T> {
  FbInputDataLTRB(String title, T value)
      : super(title, value, FbInputType.ltrb);
}

///This defines the style of the input that should be displayed
///`FbInputDataSmall<T>` tells the ui to wraps content
class FbInputDataSmall<T extends num?> extends FbInputBase<T> {
  FbInputDataSmall(String title, T value)
      : super(title, value, FbInputType.small);
}

///This defines the style of the input that should be displayed
///`FbInputDataText<T>` is used for mostly input that requires a text
class FbInputDataText extends FbInputBase<String> {
  FbInputDataText(String title, String value)
      : super(title, value, FbInputType.text);
}
