import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';

///This defines the style of inputs that allows color selection
///`FbInputDataColor<T>` tells the ui to fill the all the space horizontally
class FbInputDataColor extends BaseFbInput<int> {
  FbInputDataColor(String title, int value) : super(title, value, FbInputType.color);
}
