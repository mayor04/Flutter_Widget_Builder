import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';

///This defines the style of the input that should be displayed
///`FbInputDataText<T>` is used for mostly input that requires a text
class FbInputDataText extends BaseFbInput<String> {
  FbInputDataText(String title, String value) : super(title, value, FbInputType.text);
}
