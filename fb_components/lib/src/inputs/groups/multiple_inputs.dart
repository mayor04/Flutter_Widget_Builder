import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/extension/list_extension.dart';

///This groups has multiple sub inputs
class FbGroupMultipleInputs extends BaseFbGroupInput {
  List<BaseFbInput> fbInputs;

  FbGroupMultipleInputs(
    String title, {
    required this.fbInputs,
  }) : super(title, fbInputs, FbGroupType.multiple);

  BaseFbInput inputAt(int index) {
    var input = fbInputs.itemAt(index);

    if (input == null) {
      throw (Exception('Range Error: Unable to get input at $index for fb multiple'));
    }

    return input;
  }
}
