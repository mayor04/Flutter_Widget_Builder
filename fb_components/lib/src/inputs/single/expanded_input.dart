import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';

/// This defines the style of the input that should be displayed
/// `FbInputDataExpanded<T>` tells the ui to fill the all the space horizontally
class FbInputDataExpanded<T extends num?> extends BaseFbInput<T> {
  FbInputDataExpanded(String title, T value) : super(title, value, FbInputType.expanded);
}
