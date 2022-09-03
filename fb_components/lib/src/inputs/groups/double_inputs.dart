import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/small_input.dart';

///This groups two inputs together
///For example this groups the height and width in the same row
class FbGroupDoubleInputs extends BaseFbGroupInput {
  final FbInputDataWrap input1;
  final FbInputDataWrap input2;

  FbGroupDoubleInputs(
    String title, {
    required this.input1,
    required this.input2,
  }) : super(title, [input1, input2], FbGroupType.smallHW);
}
