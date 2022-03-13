import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';

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
