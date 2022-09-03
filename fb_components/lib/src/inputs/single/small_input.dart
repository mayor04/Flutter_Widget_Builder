import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';

/// This defines the style of the input that should be displayed
/// `FbInputDataSmall<T>` tells the ui to wraps content
class FbInputDataWrap<T extends num?> extends BaseFbInput<T> {
  FbInputDataWrap(String title, T value) : super(title, value, FbInputType.small);
}
