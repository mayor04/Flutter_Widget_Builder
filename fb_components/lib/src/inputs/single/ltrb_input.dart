import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';

/// This defines the style of the input that should be displayed
/// `FbInputDataLTRB<T>` tells the ui to fill the all the space horizontally
/// and mostly used for item like `padding`, `margin`, `border radius`
class FbInputDataLTRB<T extends List?> extends BaseFbInput<T> {
  FbInputDataLTRB(String title, T value) : super(title, value, FbInputType.ltrb);
}
