import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';

///This groups two inputs together
///For example this groups the height and width in the same row
class FbGroupHWData extends FbGroupInputBase {
  final FbInputDataSmall input1;
  final FbInputDataSmall input2;

  FbGroupHWData(
    String title, {
    required this.input1,
    required this.input2,
  }) : super(title, [input1, input2], FbGroupType.smallHW);
}

///This groups has multiple sub inputs
class FbGroupMultiple extends FbGroupInputBase {
  List<FbInputBase> fbInputs;

  FbGroupMultiple(
    String title, {
    required this.fbInputs,
  }) : super(title, fbInputs, FbGroupType.multiple);

  FbInputBase inputAt(int index) {
    var input = fbInputs.itemAt(index);

    if (input == null) {
      throw (Exception(
          'Range Error: Unable to get input at $index for fb multiple'));
    }

    return input;
  }
}
